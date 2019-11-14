{ callPackage, gitignoreSource, sqlite, crystal }:

{
  jormungandr-faucet-cr = crystal.buildCrystalPackage {
    pname = "jormungandr-faucet";
    version = "0.1.0";
    src = gitignoreSource ../.;
    crystalBinaries.server.src = "src/jormungandr-faucet.cr";
    shardsFile = ../shards.nix;
    buildInputs = [ sqlite ];
  };

  jormungandr-faucet-tests = callPackage ./nixos/tests {};
}
