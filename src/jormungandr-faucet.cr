require "http/server"
require "socket"
require "json"
require "file_utils"
require "db"
require "sqlite3"

PORT                     = ENV.fetch("PORT", "3000").to_i
SECRET_KEY               = ENV.fetch("SECRET_KEY")
LOVELACES_TO_GIVE        = ENV.fetch("LOVELACES_TO_GIVE", "3000").to_u64
SECONDS_BETWEEN_REQUESTS = ENV.fetch("SECONDS_BETWEEN_REQUESTS", "86400").to_i

module Jormungandr
  class Account
    JSON.mapping(
      counter: UInt64,
      value: UInt64,
    )

    def self.for_address(addr)
      from_json(`jcli rest v0 account get #{addr} --output-format json`)
    end
  end

  class Settings
    class Fees
      JSON.mapping(
        certificate: UInt64,
        coefficient: UInt64,
        constant: UInt64,
      )
    end

    JSON.mapping(
      fees: Fees,
      block0Hash: String
    )

    def self.get
      from_json(`jcli rest v0 settings get --output-format json`)
    end
  end

  class Faucet
    TIME_BETWEEN_REQUESTS = SECONDS_BETWEEN_REQUESTS.seconds

    alias Allow = Bool
    alias Response = {status: HTTP::Status, body: SendFundsResult | NotFoundResult | RateLimitResult}
    alias SendFundsResult = {success: Bool, amount: UInt64, fee: Int32, txid: String}
    alias RateLimitResult = {
      statusCode: Int32,
      error: String,
      message: String,
      retryAfter: Time
    }
    alias NotFoundResult = {statusCode: Int32, error: String, message: String}

    @amount : UInt64
    @settings : Settings
    @db : DB::Database

    def initialize(@amount, @db)
      @settings = Settings.get
      @db.scalar "PRAGMA journal_mode=WAL"
      @db.exec <<-SQL
        CREATE TABLE IF NOT EXISTS requests (
          host VARCHAR UNIQUE PRIMARY KEY,
          seen TIME
        )
      SQL
    end

    def on_request(context : HTTP::Server::Context) : Response
      case context.request.method
      when "POST"
        on_post(context)
      else
        on_not_found
      end
    rescue error
      on_error(error)
    end

    def on_error(error)
      {
        status: HTTP::Status::INTERNAL_SERVER_ERROR,
        body:   {
          statusCode: 500,
          error:      HTTP::Status::INTERNAL_SERVER_ERROR.to_s,
          message:    error.to_s,
        },
      }
    end

    def on_not_found
      {
        status: HTTP::Status::NOT_FOUND,
        body:   {
          statusCode: 404,
          error:      "Not Found",
          message:    "No URL found",
        },
      }
    end

    def on_post(context : HTTP::Server::Context) : Response
      match = context.request.resource.match(%r(/send-money/([^/]+)))
      return on_not_found unless match

      rate_limiter = limit_rate(
        real_ip(context.request.headers["X-Real-IP"]?) ||
        context.request.remote_address)

      if rate_limiter[:allow]
        on_send_money(match[1])
      else
        on_too_many_requests(rate_limiter[:try_again])
      end
    end

    def on_send_money(to_address : String) : Response
      result = send_funds(to_address)
      {
        status: HTTP::Status::OK,
        body:   result,
      }
    end

    def on_too_many_requests(try_again : Time) : Response
      delta = (try_again - Time.now).total_seconds.to_i
      {
        status: HTTP::Status::TOO_MANY_REQUESTS,
        body:   {
          statusCode: 429,
          error:      "Too Many Requests",
          message:    "Try again in #{delta} seconds",
          retryAfter: try_again.to_utc,
        },
      }
    end

    def real_ip(header : String) : String
      "#{header}:443"
    end

    def real_ip(header : Nil) : Nil
    end

    def limit_rate(ip : Nil) : NamedTuple(time: Time, allow: Bool, try_again: Time)
      {
        time:      Time.now,
        allow:     false,
        try_again: Time.now + TIME_BETWEEN_REQUESTS,
      }
    end

    def limit_rate(remote : String) : NamedTuple(time: Time, allow: Bool, try_again: Time)
      ip = Socket::IPAddress.parse("tcp://#{remote}").address
      allow_after = Time.now - TIME_BETWEEN_REQUESTS

      @db.query("SELECT seen FROM requests where host = ? AND seen > ?", ip, allow_after) do |rs|
        rs.each do
          seen = rs.read(Time)
          return {
            time:      seen,
            allow:     false,
            try_again: seen + TIME_BETWEEN_REQUESTS,
          }
        end
      end

      @db.exec <<-SQL, ip, Time.now
        INSERT OR REPLACE INTO requests VALUES (?, ?)
      SQL

      {
        time:      Time.now,
        allow:     true,
        try_again: allow_after,
      }
    end


    def wallet
      Path[ENV.fetch("SECRET_KEY")]
    end

    def sh(cmd, args)
      raise "Failed to execute #{cmd} #{args.join(" ")}" unless system(cmd, args)
    end

    def sh!(cmd)
      result = `#{cmd}`
      raise "Failed to execute #{cmd}" unless $?.success?
      result.strip
    end

    def send_funds(address : String) : SendFundsResult
      digest = OpenSSL::Digest.new("SHA256")
      digest.update("faucet.#{address}.#{Process.pid}.#{Time.now}")
      tmp_dir = File.join(Dir.tempdir, digest.hexdigest)

      Dir.mkdir_p(tmp_dir)

      staging_file = "#{tmp_dir}/staging.transaction"

      fee = 2 * @settings.fees.coefficient + @settings.fees.constant
      amount_with_fees = @amount + fee

      source_pk =
        Process.run("jcli", ["key", "to-public"]) do |to_public|
          File.open(wallet) do |from_wallet|
            IO.copy(from_wallet, to_public.input)
            to_public.input.close
          end

          to_public.output.gets_to_end.strip
        end

      source_addr = sh! "jcli address account --testing #{source_pk}"
      source_account = Account.for_address(source_addr)

      puts "The transaction will be posted to the blockchain with genesis hash:"
      puts "  #{@settings.block0Hash}"

      if source_account.value < amount_with_fees
        raise "Not enough funds in faucet account, only #{source_account.value} left"
      end

      sh("jcli", ["transaction", "new", "--staging", staging_file])
      sh("jcli", ["transaction", "add-account", source_addr, amount_with_fees.to_s, "--staging", staging_file])
      sh("jcli", ["transaction", "add-output", address, @amount.to_s, "--staging", staging_file])
      sh("jcli", ["transaction", "finalize", "--staging", staging_file])

      transaction_id = sh! "jcli transaction data-for-witness --staging #{staging_file}"
      witness_secret_file = File.join(tmp_dir, "witness.secret")
      witness_output_file = File.join(tmp_dir, "witness.out")
      FileUtils.cp(wallet.to_s, witness_secret_file)

      sh "jcli", [
        "transaction", "make-witness", transaction_id,
        "--genesis-block-hash", @settings.block0Hash,
        "--type", "account",
        "--account-spending-counter", source_account.counter.to_s,
        witness_output_file, witness_secret_file,
      ]

      sh "jcli", ["transaction", "add-witness", witness_output_file, "--staging", staging_file]

      sh "jcli", ["transaction", "seal", "--staging", staging_file]
      # sh "jcli", [ "transaction", "auth", "--staging", staging_file, "-k", wallet.to_s ]

      id =
        Process.run("jcli", ["rest", "v0", "message", "post"]) do |message|
          Process.run("jcli", ["transaction", "to-message", "--staging", staging_file]) do |to_msg|
            IO.copy(to_msg.output, message.input)
            message.input.close
          end

          message.output.gets_to_end.strip
        end

      puts "The id for this funds transfer transaction is: #{id}"

      {
        success: true,
        amount:  @amount,
        fee:     fee,
        txid:    id,
      }
    ensure
      FileUtils.rm_rf(tmp_dir) if tmp_dir
    end
  end
end

DB.open "sqlite3://last-seen.sqlite" do |db|
  faucet = Jormungandr::Faucet.new(LOVELACES_TO_GIVE, db)
  middleware = [HTTP::ErrorHandler.new, HTTP::LogHandler.new]
  server = HTTP::Server.new(middleware) do |context|
    context.response.content_type = "application/json"
    status_and_body = faucet.on_request(context)
    context.response.status = status_and_body[:status]
    context.response.print(status_and_body[:body].to_json)
  end

  address = server.bind_tcp(PORT)
  puts "Listening on http://#{address}"
  server.listen
end
