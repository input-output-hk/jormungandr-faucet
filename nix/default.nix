{ sources ? import ./sources.nix }:
with {
  overlay = self: super: {
    inherit (import sources.niv { }) niv;
    nodejs = super.nodejs-12_x;
    inherit (import sources.yarn2nix { pkgs = self; }) mkYarnPackage yarn2nix;
    packages = self.callPackages ./packages.nix { };
    inherit (import sources.gitignore {}) gitignoreSource;
    iohkNix = import sources.iohk-nix {
      application = "jormungandr-faucet";
      nixpkgsOverride = self;
    };
  };
};
import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
}
