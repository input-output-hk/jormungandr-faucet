{ sources ? import ./sources.nix }:
with {
  mozilla-overlay = import sources.nixpkgs-mozilla;

  overlay = self: super: {
    inherit (import sources.niv { }) niv;
    nodejs = super.nodejs-slim-11_x;
    inherit (import sources.yarn2nix { pkgs = self; }) mkYarnPackage yarn2nix;
    packages = self.callPackages ./packages.nix { };
    iohkNix = import sources.iohk-nix {
      application = "jormungandr-faucet";
      nixpkgsOverride = self;
    };

    rustc = super.latest.rustChannels.stable.rust.override {
      targets = [ "wasm32-unknown-unknown" ];
    };
  };
};
import sources.nixpkgs {
  overlays = [ mozilla-overlay overlay ];
  config = { };
}
