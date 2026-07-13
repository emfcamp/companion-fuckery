{ pkgs ? (import (import npins/default.nix).nixpkgs-unstable.outPath {}), ... }:

{
  bmd-atem = pkgs.callPackage ./bmd-atem.nix {
  };
}
