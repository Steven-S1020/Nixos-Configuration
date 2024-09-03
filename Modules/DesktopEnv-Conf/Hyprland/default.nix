# hyprland Configuration

{ config, pkgs, lib, ... }:

{
  options = {
    Hyprland.enable = lib.mkEnableOption "";
  };

  imports = [
    ./Hypr-Modules
  ];


  config = lib.mkIf config.Hyprland.enable {
    home-manager.users.steven = {pkgs, ... }: {

      wayland.windowManager.hyprland = {
        
        enable = true;
        
        systemd.variables = ["--all"];

        settings = {
          
                # Execute on startup
          exec-once = [
                  "hyprpaper"
                ];

          # Monitors
                # "name, resolution, position, scale"
          monitor = [
                  "eDP-1, preferred, auto-left, 1"
                  "DP-3, preferred, auto, 1"
                  "DP-4, preferred, auto-right, 1"
                ];

          # Keyboard Bindings
                "$mainMod" = "SUPER";

                bind = [
            "$mainMod, Return, exec, alacritty"
            "$mainMod, Q, killactive"
                  "$mainMod, F, fullscreen"
                ];
                bindr = [
                  "$mainMod, SUPER_L, exec, pkill rofi || rofi -show drun"
                  #-show drun -show-icons -[no-]steal-focus
                ];  
          binde = [  
                  # Move Window
                  "$mainMod, left, movewindow, l"
                  "$mainMod, right, movewindow, r"
                  "$mainMod, up, movewindow, u"
                  "$mainMod, down, movewindow, d"

                  # Change Active Window
                  "$mainMod SHIFT, left, movefocus, l"
                  "$mainMod SHIFT, right, movefocus, r"
                  "$mainMod SHIFT, up, movefocus, u"
                  "$mainMod SHIFT, down, movefocus, d"

                  # Resize Active Window
                  "ALT, left, resizeactive, -30 0"
                  "ALT, right, resizeactive, 30 0"
                  "ALT, up, resizeactive, 0 -30"
                  "ALT, down, resizeactive, 0 30"
                ];
                bindl = [
                  ",switch:[235b500],exec,hyprlock"
                  ",switch:on:[235b500],exec,hyprctl keyword monitor \"eDP-1, disable\""
                  ",switch:off:[235b500],exec,hyprctl keyword monitor \"eDP-1, preferred, 0x0, 1\""
                ];  

          general = {
                  gaps_in = 8;
                  gaps_out = 16;
                  border_size = 4;
                  "col.active_border" = "rgb(d08484) 45deg";
                  "col.inactive_border" = "rgb(ac4242)";
          };

          decoration = {
            rounding = 10;
                  blur = {
                    enabled = true;
              size = 3;
                    passes = 1;
            };
                  drop_shadow = true;
                  shadow_range = 4;
                  shadow_render_power = 3;
            "col.shadow" = "rgba(1a1a1a33)";
                };
        };  
      };
    };
  };
}
