# rofi Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.rofi = {

      enable = true;

    };
  };
}
