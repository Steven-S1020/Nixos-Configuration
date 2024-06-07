# fastfetch Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.fastfetch = {

      enable = true;

      # Logo Settings	
      settings.logo = {
        source = "nixos_medium";
	color = {
	  "1" = "38;2;172;66;66";
	  "2" = "38;2;58;48;48";
	};  
        padding = {
	  top = 2;
          left = 2;
	  right = 20;
        };
	preserveAspectRatio = false;
      };

      # Display Settings
      settings.display = {
        binaryPrefix = "si";
	color = "red";
	separator = " ";
	size = { 
	  ndigits = 0;
	};
	percent = {
	  type = 3;
	};
	bar = {
	  charElapsed = "";
	  charTotal = " ";
	};
	keyWidth = 6;
      };	

      # Modules
      settings.modules = [

        # First Module Group
	"break"
	"break"
	"break"
        {
	  type = "title";
	}

	{
	  type = "separator";
	  string = "▔";
        }

	{
	  type = "datetime";
	  key = "╭─";
	  format = "{14}:{17}:{20}";
	}

	{
	  type = "datetime";
	  key = "├─󰸗";
	  format = "{1}-{3}-{11}";
	}

	{
          type = "uptime";
	  key = "╰─󰔚";
	}
	"break"
	#------------------------#

	# Second Module Group
	{
          type = "os";
          key = "╭─";
          format = "{3} ({12})";
	}

        {
          type = "cpu";
          key = "├─";
          freqNdigits = 1;
	}

        {
          type = "board";
          key = "├─󱤓";
        }

	{
	  type = "gpu";
	  key = "├─󰢮";
	  format = "{1}";
	}

	{
	  type = "sound";
	  key = "├─󰓃";
	  format = "{2}";
        }

	{
	  type = "memory";
	  key = "├─";
	}

	{
          type = "disk";
          key = "├─󰋊";
	}

        {
          type  = "localip";
          key = "╰─󱦂";
          showIpv4 = true;
          compact = true;
        }
      ];	
    };
  };  
}

 
