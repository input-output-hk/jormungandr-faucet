#!/usr/bin/env node

// Require the framework and instantiate it
const fastify = require("fastify")({ logger: true });
const fastifyEnv = require("fastify-env");
const { open: openLmdb } = require("lmdb-store");
const chainLibs = require("./js-chain-libs/js_chain_libs");
const jormungandrApi = require("./jormugandr_api.js");

// Get config from .env file
const schema = {
  type: "object",
  required: [
    "JORMUNGANDR_API",
    "SECRET_KEY",
    "LOVELACES_TO_GIVE",
    "SECONDS_BETWEEN_REQUESTS"
  ],
  properties: {
    // The node address
    JORMUNGANDR_API: {
      type: "string",
      default: "http://localhost:8443/api"
    },
    // The faucet secret key in bech32 format
    SECRET_KEY: {
      type: "string"
    },
    // The port to listen to
    PORT: {
      type: "string",
      default: 3000
    },
    // Fixed amount of lovelaces to give on each request
    LOVELACES_TO_GIVE: {
      type: "number",
      default: 3000
    },
    // time between faucet payout requests in seconds
    SECONDS_BETWEEN_REQUESTS: {
      type: "number",
      default: 24 * 60 * 60
    }
  }
};

const options = {
  schema,
  dotenv: true
};

const lastRequests = openLmdb("lastRequests.mdb", {
  useWritemap: true
});

fastify.addHook("onRequest", (request, reply, done) => {
  let ip = request.headers["x-real-ip"];
  if (!ip) ip = request.headers["host"];
  fastify.log.info(`Request from ${ip}`);
  const requestHost = Buffer.from(ip);

  lastRequests.transaction(() => {
    const previous = lastRequests.get(requestHost);

    if (previous === undefined) {
      lastRequests.put(requestHost, Buffer.from(Date.now().toString()));
      done();
    } else {
      const time = Number.parseInt(previous, 10);
      const now = Date.now();
      const delta = fastify.config.SECONDS_BETWEEN_REQUESTS * 1000;

      if (now - time > delta) {
        lastRequests.put(requestHost, Buffer.from(Date.now().toString()));
        done();
      } else {
        const retryAt = new Date(delta + time).toISOString();

        reply.code(429);
        done({
          statusCode: 429,
          error: "Too Many Requests",
          message: `Try again in ${(delta + time - now) / 1000} seconds`,
          retryAfter: retryAt
        });
      }
    }
  });
});

fastify.post("/send-money/:destinationAddress", async (request, reply) => {
  try {
    const {
      OutputPolicy,
      TransactionBuilder,
      Address,
      Input,
      Value,
      Fee,
      Fragment,
      PrivateKey,
      Witness,
      SpendingCounter,
      Hash,
      Account,
      InputOutputBuilder,
      PayloadAuthData,
      Payload,
      Witnesses,
      // eslint-disable-next-line camelcase
      uint8array_to_hex
    } = await chainLibs;

    // From the settings we can get:
    // the block0hash used for signing
    // the transaction fees
    const nodeSettings = await jormungandrApi.getNodeSettings(
      fastify.config.JORMUNGANDR_API
    );

    const iobuilder = InputOutputBuilder.empty();

    const secretKey = PrivateKey.from_bech32(fastify.config.SECRET_KEY);
    const faucetAccount = Account.from_public_key(secretKey.to_public());

    // Fee (#inputs + #outputs) * coefficient + constant + #certificates*certificate
    // #inputs = 1; #outputs = 2; #certificates = 0
    const computedFee =
      (1 + 1) * nodeSettings.fees.coefficient + nodeSettings.fees.constant;

    const inputAmount = fastify.config.LOVELACES_TO_GIVE + computedFee;
    const input = Input.from_account(
      faucetAccount,
      Value.from_str(inputAmount.toString())
    );

    iobuilder.add_input(input);

    iobuilder.add_output(
      Address.from_string(request.params.destinationAddress),
      Value.from_str(fastify.config.LOVELACES_TO_GIVE.toString())
    );

    const feeAlgorithm = Fee.linear_fee(
      Value.from_str(nodeSettings.fees.constant.toString()),
      Value.from_str(nodeSettings.fees.coefficient.toString()),
      Value.from_str(nodeSettings.fees.certificate.toString())
    );

    // The amount is exact, that's why we use `forget()`
    const IOs = iobuilder.seal_with_output_policy(
      Payload.no_payload(),
      feeAlgorithm,
      OutputPolicy.forget()
    );

    // To get the account counter used for signing
    const accountStatus = await jormungandrApi.getAccountStatus(
      fastify.config.JORMUNGANDR_API,
      uint8array_to_hex(secretKey.to_public().as_bytes())
    );

    const builderSetWitness = new TransactionBuilder()
      .no_payload()
      .set_ios(IOs.inputs(), IOs.outputs());

    const witness = Witness.for_account(
      Hash.from_hex(nodeSettings.block0Hash),
      builderSetWitness.get_auth_data_for_witness(),
      secretKey,
      SpendingCounter.from_u32(accountStatus.counter)
    );

    const witnesses = Witnesses.new();
    witnesses.add(witness);

    const signedTx = builderSetWitness
      .set_witnesses(witnesses)
      .set_payload_auth(PayloadAuthData.for_no_payload());

    const message = Fragment.from_transaction(signedTx);

    // Send the transaction
    await jormungandrApi.postMsg(
      fastify.config.JORMUNGANDR_API,
      message.as_bytes()
    );

    reply.code(200).send({
      success: true,
      amount: fastify.config.LOVELACES_TO_GIVE,
      fee: computedFee,
      txid: uint8array_to_hex(message.id().as_bytes())
    });
  } catch (err) {
    fastify.log.error(err);
    reply.code(500).send(JSON.stringify({ success: false, error: err }));
  }
});

fastify.register(fastifyEnv, options).ready(err => {
  if (err) fastify.log.error(err);
  start();
});

const start = async () => {
  try {
    await fastify.listen(fastify.config.PORT);
    fastify.log.info(`server listening on ${fastify.server.address().port}`);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
