{ config, lib, pkgs, ... }:

let
  cfg = config.services.jormungandr-faucet;
  inherit (lib) mkOption types mkIf;
in {
  options.services.jormungandr-faucet.enable = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Enable the Jormungandr Faucet, an HTTP service that talks to Jormungandr
      to spread ADA love.
    '';
  };

  config = mkIf cfg.enable {
    systemd.services.jormungandr-faucet = {
      description = "jormungandr-faucet daemon";
      after = [ "jormungandr.service"];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        DynamicUser = true;
        Restart = "always";
        User = "jormungandr-faucet";
        StateDirectory = "jormungandr-faucet";
        WorkingDirectory = "/var/lib/jormungandr-faucet";
        PermissionsStartOnly = true;
        ExecStart = "${cfg.package}/bin/server";
      };

      environment = {
        JORMUNGANDR_RESTAPI_URL = cfg.jormungandrApi;
        PORT = toString cfg.port;
        LOVELACES_TO_GIVE = toString cfg.lovelacesToGive;
        SECONDS_BETWEEN_REQUESTS = toString cfg.secondsBetweenRequests;
        SECRET_KEY = "/var/lib/private/jormungandr-faucet/faucet.sk";
      };

      preStart = ''
        cp ${cfg.secretKeyPath} /var/lib/private/jormungandr-faucet/faucet.sk
        chmod 0644 /var/lib/private/jormungandr-faucet/faucet.sk
      '';

      path = [ cfg.jormungandrCliPackage ];
    };
  };
}
