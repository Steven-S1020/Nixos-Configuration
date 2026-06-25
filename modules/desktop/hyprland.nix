{
  den.aspects.desktop._.hyprland = 
  ({ host, ... }:
  {
    nixos = { pkgs, ... }:
    {
        programs.hyprland = {
            enable = true;
            withUWSM = true;
            # xwayland.enable = true;
        };

        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        environment.systemPackages = with pkgs; [
          brightnessctl
        ];

        # maybe installing gnome fixes hyprland screensharing
services.desktopManager.gnome.enable = true;
    # Exclude unnecessary packages (i.e., bloat)
    environment.gnome.excludePackages = with pkgs; [
      decibels
      epiphany
      geary
      gnome-calculator
      gnome-calendar
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-text-editor
      gnome-tour
      gnome-weather
      loupe
      papers
      showtime
      simple-scan
      snapshot
      totem
      yelp
    ];
    };
    homeManager =
      { pkgs, config, ... }:
      {
        systemd.user.targets.hyprland-session = {
          Unit = {
            Description = "Hyprland session";
            BindsTo = [ "graphical-session.target" ];
            Wants = [ "graphical-session-pre.target" ];
            After = [ "graphical-session-pre.target" ];
            # PropagatesStopTo = [ "graphical-session.target" ];
          };
        };

        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ 
            xdg-desktop-portal-gtk
          ];
          config.common.default = [ "gtk" ];
        };

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
      '' else null;
      };
  });
}
