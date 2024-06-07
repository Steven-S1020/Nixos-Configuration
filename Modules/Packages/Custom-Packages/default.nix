{ pkgs, config, lib, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    base16preview = pkgs.callPackage ./base16Preview/default.nix { };
  };  
}
