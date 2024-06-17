# waybar Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.waybar = {

      enable = true;
            
      settings = {
        mainBar = {
          layer = "top";
	  position = "top";
	  height = 30;

	  modules-left = ["sway/mode"];
        
	};
      };
    };
  };
}
