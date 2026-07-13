let
  sources = import npins/default.nix;
  nixpkgs-unstable = sources."nixpkgs-unstable".outPath;
  pkgs = import "${nixpkgs-unstable}" {
localSystem = "aarch64-linux"; targetSystem = "aarch64-linux";
};
in
{
  bmd-atem = pkgs.callPackage ./bmd-atem.nix {
  };
}
