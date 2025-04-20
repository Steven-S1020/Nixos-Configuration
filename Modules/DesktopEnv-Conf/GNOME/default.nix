{
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    GNOME.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.GNOME.enable {
    services.xserver = {
      desktopManager.gnome.enable = true;
    };
    # Enable Gnome Display Manager
    services.xserver.displayManager.gdm.enable = true;

    # Exclude GNOME bloat
    environment.gnome.excludePackages =
      (with pkgs; [
        epiphany
        geary
        gnome-console
        gnome-connections
        gnome-tour
        yelp
      ])
      ++ (with pkgs; [
        gnome-contacts
        gnome-maps
        gnome-clocks
        gnome-weather
      ]);

    # GNOME Theming
    programs.dconf.enable = true;

    home-manager.users.steven = {

      gtk = {
        enable = true;

        iconTheme = {
          name = "Colloid-red-dark";
          package = pkgs.colloid-icon-theme.override {
            colorVariants = [ "red" ];
          };
        };
        /*
                 theme = {
                  name = "Colloid-Red-Dark";
                  package = pkgs.colloid-gtk-theme.override {
                    themeVariants = [ "red" ];
                    colorVariants = [ "dark" ];
                    tweaks = [ "black" ];
                  };
                };
        */
      };

      # dconf Settings for GNOME
      dconf.settings = {

        # Setting Certain GNOME Settings
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
        };
        # Keybindsings
        "org/gnome/settings-daemon/plugins/media-keys" = {
          help = "@as []";
        };
        "org/gnome/shell/keybindings" = {
          show-screen-recording-ui = "@as []";
        };
        # Force removal of disabled extensions
        # and enable user-theme
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disable-extensions = [ ];
          enable-extensions = [
            "hidetopbar@mathieu.bidon.ca"
            "user-theme@gnome-shell-extensions.gcampx.github.com"
          ];
        };
       /* 
          # Set Shell Theme
          "org/gnome/shell/extensions/user-theme" = {
            name = "catppuccin-mocha-red-standard";
          };

          # Set Wallpaper
          "org/gnome/desktop/background" = {
            picture-uri = "file:///etc/nixos/Assets/Wallpapers/nixos-red.png";
            picture-uri-dark = "file:///etc/nixos/Assets/Wallpapers/nixos-red.png";
          };

          # Set Greeter Wallpaper
          "org/gnome/desktop/screensaver" = {
            picture-uri = "file:///etc/nixos/Assets/nixos-red.png";
          };
        */
      };
    };
  };
}
