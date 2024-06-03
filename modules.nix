# Where All Modules should 

{ config, pkgs, lib, ... }:

{
  imports = 
    [
      ./Modules/system.nix
      ./Modules/packages.nix
      ./Modules/home-manager.nix
    ];
}

