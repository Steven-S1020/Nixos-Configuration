# fastfetch Configuration

{ ... }:

{
  home-manager.users.steven = {
    programs.fastfetch = {

      enable = true;

      settings = {
        # Logo Settings
        logo = {
          source = "/etc/nixos/Assets/ASCII-Art/Red-Flake.txt";
          padding = {
            top = 1;
            left = 5;
            right = 5;
          };
          preserveAspectRatio = false;
        };

        # Display Settings
        display = {
          size.binaryPrefix = "si";
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

          key.width = 6;
        };

        # Modules
        modules = [

          # First Module Group
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
            format = "{1} {2}";
          }
          {
            type = "sound";
            key = "├─󰓃";
            format = "{2}";
          }
          {
            type = "memory";
            key = "├─";
            format = "{2} RAM";
          }
          {
            type = "disk";
            key = "├─󰋊";
            format = "{2} DSK";
          }
          {
            type = "localip";
            key = "╰─󱦂";
            showIpv4 = true;
            compact = true;
          }
        ];
      };
    };
  };
}
