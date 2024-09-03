{ pkgs, config, lib, ... }:

{
  options = {
    GNOME.enable = lib.mkEnableOption "";
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
      gnome-tour
      yelp
    ]) ++ (with pkgs.gnome; [
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

        # Force removal of disabled extensions
        # and enable user-theme
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disable-extensions = [];
          enable-extensions = [
            "openbar@neuromorph"
           #"user-theme@gnome-shell-extensions.gcampx.github.com"
          ];
        };
/* 
         Set Shell Theme
        "org/gnome/shell/extensions/user-theme" = {
          name = "Colloid-Red-Dark";
        };

        # Set Wallpaper  
        "org/gnome/desktop/background" = {
          picture-uri = "file:///etc/nixos/Assets/nixos-red.png";
          picture-uri-dark = "file:///etc/nixos/Assets/nixos-red.png";
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

