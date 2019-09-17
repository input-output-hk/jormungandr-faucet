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
        RestartSec = "10s";
        StartLimitBurst = 50;
        StateDirectory = "jormungandr-faucet";
      };

      environment = {
        JORMUNGANDR_API = cfg.jormungandrApi;
        PORT = toString cfg.port;
        LOVELACES_TO_GIVE = toString cfg.lovelacesToGive;
      };

      serviceConfig.PermissionsStartOnly = true;
      preStart = ''
        ls -la /var/lib
        cp ${cfg.secretKeyPath} /var/lib/private/jormungandr-faucet/faucet.sk
      '';

      script = ''
        export SECRET_KEY="$(< /var/lib/private/jormungandr-faucet/faucet.sk)"
        ${cfg.package}/bin/faucet
      '';
    };
  };
}
