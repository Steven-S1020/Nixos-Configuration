# rofi-wayland Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.rofi-wayland = {

      enable = true;

    };
  };
}
