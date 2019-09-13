# jormungandr-faucet

A simple faucet API server for Jörmungandr.

## Running

To run locally, make sure you have [Jörmungandr](https://input-output-hk.github.io/jormungandr/) running.
The easiest way to do that is to:

```shell-session
$ git clone https://github.com/input-output-hk/jormungandr-nix
$ cd jormungandr-nix
$ nix-shell --run run-jormungandr
```

The output will give you 3 faucet accounts, pick one and copy its `secret` into
a file called `.env` that should look like this:

```sh
JORMUNGANDR_API=http://localhost:8443/api/v0
SECRET_KEY=PUT_THE_SECRET_KEY_HERE
PORT=3000
LOVELACES_TO_GIVE=1000
```

After that, you can run the server:

```shell-session
$ nix-shell --run 'yarn && yarn run server'
```

## Usage

There are a number of helper scripts in the `jormungandr-nix` project that allow
easy testing of the faucet. I'll assume that you have already started
Jörmungandr, so you need to open a second shell, go to the project, and first
create a wallet using:

```shell-session
$ jcli-generate-account
new account parameter:
* SK: ed25519_sk1wn38rhp3w2hpnf02wr8u686zcev75nmepw94ahqk3xh8n80rd5vsck7w4k
* PK: ed25519_pk1xw20l8sk5xyg7fzf4tvdlxtz2y6q3l58qjj8vg6n2r2kazvmd7jqzwz0xy
* ADDR: ca1s5eeflu7z6sc3reyfx4d3huevfgngz87suz2ga3r2dgd2m5fndh6gcz8cm4

```

Now we can test sending some funds to the new account from our faucet:

```shall-session
$ curl -X POST http://localhost:3000/send-money/ca1s5eeflu7z6sc3reyfx4d3huevfgngz87suz2ga3r2dgd2m5fndh6gcz8cm4
{"success":true}
```

Wait after that until a new block has been made, and check the result:

```shall-session
$ jcli rest v0 account get ca1s5eeflu7z6sc3reyfx4d3huevfgngz87suz2ga3r2dgd2m5fndh6gcz8cm4 --host http://127.0.0.1:8443/api
---
counter: 0
delegation: ~
value: 1000
```

And here is the faucet account, now a bit less wealthy:

```shell-session
$ jcli rest v0 account get ca1s4f9p67e5pfq9paytmdt3s8arms4xw24fmp7ca8hmac7va5d8aumzcvhvvt --host http://127.0.0.1:8443/api
---
counter: 1
delegation: 161f8cd33097597a2870e82842bc8918c51ed4589b664bc70429fc8174b59d5e
value: 999998990
```

Per block, one request to receive funds can be made, any other requests return
success, but will be ignored.

## Development

To build the webassembly for latest js-chain-libs master, you can run

```shall-session
./update-js-chain-libs.sh
```
