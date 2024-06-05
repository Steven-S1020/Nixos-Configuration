# hyprland Configuration

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hypr-modules.nix
    ];


  home-manager.users.steven = {pkgs, ... }: {

    wayland.windowManager.hyprland = {

      enable = true;

      settings = {

        # Monitors
	# "name, resolution, position, scale"
        monitor = [
	  "DP-3, preferred, auto-left, 1"
	  "DP-4, preferred, auto-right, 1"
	  ];

        # Keyboard Bindings
	"$mod" = "SUPER";

	bind = [
          "$mod, Return, exec, alacritty"
          "$mod, Q, killactive"
	  "$mod, F, fullscreen"
	  "$mod, exec, wofi"
        ];
      };
    };
  };  
}