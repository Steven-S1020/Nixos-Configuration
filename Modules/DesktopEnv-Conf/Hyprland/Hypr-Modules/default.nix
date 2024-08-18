# Where All Modules should 

{ config, pkgs, lib, ... }:

{
  imports = 
    [
      ./waybar.nix
      ./rofi.nix
   ];
}

