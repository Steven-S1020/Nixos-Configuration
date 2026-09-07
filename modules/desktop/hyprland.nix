{
  den.aspects.desktop._.hyprland = 
  ({ host, ... }:
  {
    nixos = { pkgs, ... }:
    {
        programs.hyprland = {
            enable = true;
            withUWSM = true;
        };

        environment.systemPackages = with pkgs; [
          brightnessctl
        ];
    };
    homeManager =
      { pkgs, config, ... }:
      {
        xdg.configFile."hypr/hyprland.lua".text = /* lua */ ''
          require 'config'
        '';

        xdg.configFile."hypr/config".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/desktop/_hypr";
      
        xdg.configFile."hypr/generated/local.lua".text = if host.hostName == "Deimos" then /* lua */ ''
          hl.on('hyprland.start', function()
              hl.exec_cmd '${pkgs.xrandr}/bin/xrandr --output DP-1 --primary'
          end)

          hl.monitor {
              output = 'DP-1',
              mode = '2560x1440@200',
              position = '0x0',
              scale = '1.0',
          }

          hl.monitor {
              output = 'HDMI-A-1',
              mode = '1920x1080',
              position = '2560x0',
              scale = '1.0',
          }
      '' else "";
      };
  });
}
