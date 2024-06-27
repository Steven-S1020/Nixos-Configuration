# hyprpaper Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    services.hyprpaper = {

      enable = true;

      settings = {

        # Set splash message state
        splash = false;

        # Load wallpapers into memory
        preload = [
          "/etc/nixos/Assets/nixos-red.png"
        ];

        # Apply loaded wallpaper to specific or all montors
        wallpaper = [
          ",/etc/nixos/Assets/nixos-red.png"
        ];

      };
    };
  };
}
