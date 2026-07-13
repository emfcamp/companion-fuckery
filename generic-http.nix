{ stdenv, nodejs, yarn-berry_4, yarn, yarnBuildHook, lib }:

let
  yarn-berry = yarn-berry_4;
  sources = import ./npins/default.nix;
  source = sources.companion-module-generic-http;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "companion-module-generic-http";
  version = source.version;

  src = source.outPath;

  nativeBuildInputs = [
    nodejs
    yarn-berry
    yarn-berry.yarnBerryConfigHook
  ];

  installPhase = ''
    mkdir $out/
    cp -rv ./* $out/
  '';

  missingHashes = ./generic-http-missing-hashes.json;
  offlineCache = yarn-berry.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    hash = "sha256-vuJBaZ8GggJbvr233lxPxnuhPkiapm4igsbTAAkOy/M=";
  };
})
