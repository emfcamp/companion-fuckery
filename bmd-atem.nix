{ stdenv, nodejs, yarn-berry_4, yarn, yarnBuildHook, lib }:

let
  yarn-berry = yarn-berry_4;
  sources = import ./npins/default.nix;
  source = sources.companion-module-bmd-atem;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "companion-module-bmd-atem";
  version = source.version;

  src = source.outPath;

  nativeBuildInputs = [
    nodejs
    yarn-berry
    yarn-berry.yarnBerryConfigHook
  ];

  buildPhase = ''
    yarn build
  '';

  installPhase = ''
    mkdir $out/
    cp -rv ./* $out/
  '';

  missingHashes = ./bmd-atem-missing-hashes.json;
  offlineCache = yarn-berry.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    hash = "sha256-dKeBctz+5oEyl7RGexYnO8PfS3BLXrSRhvFtD8LrZcU=";
  };
})
