# Alacritty Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.alacritty = {
    
      enable = true;

      # Change Font
      settings.font.normal = {
        family = "FiraCode Nerd Font"; 
        style = "Regular";
      };

      # Change Window Size
      settings.window.dimensions = {
        columns = 120;
	lines = 35;
      };
    };
  };
}

