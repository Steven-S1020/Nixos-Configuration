{ pkgs, config, lib, ... }:

{
  options = {
    GNOME.enable = lib.mkEnableOption "fuck";
  };

  config = lib.mkIf config.GNOME.enable {
    services.xserver = {
      desktopManager.gnome.enable = true;
    };

    # Exclude GNOME bloat
    environment.gnome.excludePackages = (with pkgs; [
      epiphany
      geary
      gnome-console
      gnome-connections
    ]) ++ (with pkgs.gnome; [
      gnome-contacts
      gnome-maps
    ]);

    # GNOME Theming
    programs.dconf.enable = true;

    home-manager.users.steven = {
      gtk = {
        enable = true;

        theme = {
          name = "catppuccin-mocha-red-standard";
          package = pkgs.catppuccin-gtk.override {
            accents = [ "red" ];
            variant = "mocha";
            size = "standard";
          };
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders.override {
            flavor = "mocha";
            accent = "red";
          };
        };
      };

      dconf.settings = {
        # Force removal of disabled extensions
        # and enable user-theme
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disable-extensions = [];
          enable-extensions = [
            "user-theme@gnome-shell-extensions.gcampx.github.com"
          ];
        };

        "org/gnome/desktop/background" = {
          picture-uri = "file:///etc/nixos/Assets/nixos-red.png";
          picture-uri-dark = "file:///etc/nixos/Assets/nixos-red.png";
        };
      };
    };
  };
}
