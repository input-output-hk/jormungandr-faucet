#! /usr/bin/env nix-shell
#! nix-shell --pure -I nixpkgs=nix -p cacert git rustc wasm-pack -i bash

set -euxo pipefail

if [ ! -d tmp/js-chain-libs ]; then
    git clone \
      https://github.com/input-output-hk/js-chain-libs \
      tmp/js-chain-libs \
      --recurse-submodules
else
    git -C tmp/js-chain-libs pull
fi

wasm-pack build tmp/js-chain-libs --target nodejs --out-dir ../../js-chain-libs
rm js-chain-libs/.gitignore
