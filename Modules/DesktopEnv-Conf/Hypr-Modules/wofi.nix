# wofi Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.wofi = {

      enable = true;

    };
  };
}
