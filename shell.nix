with { pkgs = import ./nix { }; };
pkgs.mkShell {
  buildInputs = with pkgs; [
    niv
    cacert
    crystal
    shards
    sqliteInteractive
    sqlite
    crystal2nix
  ];
}
