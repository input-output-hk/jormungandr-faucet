{ stdenv, mkYarnPackage, yarn2nix, callPackage }:

{
  jormungandr-faucet-js = mkYarnPackage {
    name = "jormungandr-faucet";
    src = ../.;
    packageJSON = ../package.json;
    yarnLock = ../yarn.lock;
  };

  jormungandr-faucet-tests = callPackage ./nixos/tests {};
}
