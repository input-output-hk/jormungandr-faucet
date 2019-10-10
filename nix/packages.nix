{ stdenv, mkYarnPackage, yarn2nix, callPackage, lmdb, python, nodejs }:

{
  jormungandr-faucet-js = mkYarnPackage {
    name = "jormungandr-faucet";
    src = stdenv.lib.cleanSource ../.;
    packageJSON = ../package.json;
    yarnLock = ../yarn.lock;
    yarnNix = ../yarn.nix;
    inherit nodejs;

    yarnPreBuild = ''
      mkdir -p $HOME/.node-gyp/${nodejs.version}
      echo 9 > $HOME/.node-gyp/${nodejs.version}/installVersion
      ln -sfv ${nodejs}/include $HOME/.node-gyp/${nodejs.version}
    '';

    pkgConfig = {
      node-lmdb = {
        buildInputs = [ lmdb python ];
        postInstall = ''
          ${nodejs}/lib/node_modules/npm/bin/node-gyp-bin/node-gyp configure
          ${nodejs}/lib/node_modules/npm/bin/node-gyp-bin/node-gyp build
        '';
      };
    };
  };

  jormungandr-faucet-tests = callPackage ./nixos/tests {};
}
