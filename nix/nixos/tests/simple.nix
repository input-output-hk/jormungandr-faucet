{ pkgs , ... }:

{
  name = "jormungandr-faucet-test";
  nodes = {
    machine = { config, pkgs, ... }: {
      imports = [
        ../.
      ];
      services = {
        jormungandr-faucet = {
          enable = true;
        };

        jormungandr = {
          enable = true;
        };
      };
    };
  };
  testScript = ''
    startAll
    $machine->execute("mkdir -p /var/lib/keys");
    $machine->execute("echo SECRET_KEY=key > /var/lib/keys/jormungandr-faucet.key");
    $machine->waitForUnit("jormungandr-faucet.service");
    $machine->waitForOpenPort(3008);
  '';

}
