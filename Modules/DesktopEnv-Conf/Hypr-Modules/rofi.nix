# rofi Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.rofi = {

      enable = true;

      extraConfig = {

        modi = "drun";
        show-icons = true;
        location = 0;
        font = "FiraCode Nerd Font 12";
        drun-display-format = "{icon} {name}";
        display-drun = "  Apps";
        steal-focus = true;

      };
    };
  };
}
