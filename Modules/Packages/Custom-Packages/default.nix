{ ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    mkdev = pkgs.callPackage ./mkdev { };
  };
}
