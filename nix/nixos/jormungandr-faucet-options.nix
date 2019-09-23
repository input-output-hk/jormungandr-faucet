{ config, lib, pkgs, ... }:

let
  jormungandr-faucet = (import ../. { }).packages.jormungandr-faucet;
  cfg = config.services.jormungandr-faucet;
  inherit (lib) mkOption types;
in {
  options.services.jormungandr-faucet = {
    package = mkOption {
      type = types.package;
      default = (import ../. {}).packages.jormungandr-faucet-js;
      defaultText = "jormungandr-faucet";
      description = ''
        The jormungandr-faucet package to be used
      '';
    };

    jormungandrApi = mkOption {
      type = types.str;
      default = "http://localhost:8443/api/v0";
    };

    secretKeyPath = mkOption {
      type = types.str;
      default = "/var/lib/keys/jormungandr-faucet.sk";
    };

    port = mkOption {
      type = types.port;
      default = 3008;
    };

    lovelacesToGive = mkOption {
      type = types.int;
      default = 1;
    };

    secondsBetweenRequests = mkOption {
      type = types.int;
      default = 24 * 60 * 60;
    };
  };
}
