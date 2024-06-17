# Where All Modules should 

{ config, pkgs, lib, ... }:

{
  imports = 
    [
      ./Hypr-Modules/waybar.nix
      ./Hypr-Modules/rofi.nix
   ];
}

