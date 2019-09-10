with { pkgs = import ./nix { }; };
pkgs.mkShell {
  buildInputs = with pkgs; [
    niv
    yarn2nix
    yarn
    nodejs
    wasm-pack
    cacert
    rustc
    cargo
  ];
}
