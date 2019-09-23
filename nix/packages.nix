{ stdenv, mkYarnPackage, yarn2nix, callPackage, lmdb }:

{
  jormungandr-faucet-js = mkYarnPackage {
    name = "jormungandr-faucet";
    src = ../.;
    packageJSON = ../package.json;
    yarnLock = ../yarn.lock;
    yarnNix = ../yarn.nix;
    pkgConfig = {
      node-lmdb = {
        buildInputs = [ lmdb ];
      };
    };
  };

  jormungandr-faucet-tests = callPackage ./nixos/tests {};
}
