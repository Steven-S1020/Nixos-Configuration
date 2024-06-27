# waybar Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.waybar = {

      enable = true;
            
      settings = [
        { 
          layer = "top";
	  position = "top";
	  height = 30;

	  modules-center = ["clock"];
          
          "clock" = {
	    format = ''  {:L%I:%M %p}'';
	    tooltip = true;
	    tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
	  };  
	}
      ];
    };
  };
}
