{ pkgs, ... }:

let
  Future-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "Future-cursors";
    version = "0.0.1";
    src = pkgs.fetchFromGitHub {
      owner = "yeyushengfan258";
      repo = "Future-cursors";
      rev = "587c14d2f5bd2dc34095a4efbb1a729eb72a1d36";
      hash = "sha256-ziEgMasNVhfzqeURjYJK1l5BeIHk8GK6C4ONHQR7FyY=";
    };

    postInstall = ''
      sed -i '$s/.*/create svg-dark/' $src/build.sh && $src/build.sh

      mkdir -p $out/share/icons/Future-cursors

      cp -r $src/dist/* $out/share/icons/Future-cursors
    '';
  };

in {
  environment.systemPackages = [
    Future-cursors
  ];
}
