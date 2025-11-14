{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];

    home-manager.users.steven = {

      wayland.windowManager.hyprland.settings =
        let
          noctalia =
            cmd:
            lib.concatStringsSep " " (
              [
                "noctalia-shell"
                "ipc"
                "call"
              ]
              ++ (pkgs.lib.splitString " " cmd)
            );
        in
        {
          "$mod" = "SUPER";

          bind = [
            # General
            "$mod, Q, killactive"
            "$mod, E, exec, nautilus"
            "$mod, ENTER, exec, kitty"
            "Alt_L, Space, exec, ${noctalia "launcher toggle"}"
            "Control_L+Shift, Escape, exec, kitty btop"

            # Fullscreen control
            "$mod, M, fullscreen, 1"
            "$mod+Shift, M, fullscreen, 0"

            # Float
            "$mod, F, togglefloating"
            "$mod, F, resizeactive, exact 65% 65%"
            "$mod, F, centerwindow"

            # Minimize trick
            "$mod, Z, togglespecialworkspace, mincontainer"
            "$mod, Z, movetoworkspace, +0"
            "$mod, Z, togglespecialworkspace, mincontainer"
            "$mod, Z, movetoworkspace, special:mincontainer"
            "$mod, Z, togglespecialworkspace, mincontainer"

            # System Power
            "$mod, L, exec, hyprlock"
            "$mod, V, exec, hyprctl dispatch exit"
            "$mod+Shift, V, exec, shutdown now"

            # Window Focus
            "Alt_L, H, movefocus, l"
            "Alt_L, J, movefocus, d"
            "Alt_L, K, movefocus, u"
            "Alt_L, L, movefocus, r"
            "Alt_L, TAB, cyclenext, visible"

            # Move Window
            "$mod+Shift, H, movewindow, l"
            "$mod+Shift, J, movewindow, d"
            "$mod+Shift, K, movewindow, u"
            "$mod+Shift, L, movewindow, r"

            # Change Workspace
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # Move Window to Workspace
            "$mod+Shift, 1, movetoworkspace, 1"
            "$mod+Shift, 2, movetoworkspace, 2"
            "$mod+Shift, 3, movetoworkspace, 3"
            "$mod+Shift, 4, movetoworkspace, 4"
            "$mod+Shift, 5, movetoworkspace, 5"
            "$mod+Shift, 6, movetoworkspace, 6"
            "$mod+Shift, 7, movetoworkspace, 7"
            "$mod+Shift, 8, movetoworkspace, 8"
            "$mod+Shift, 9, movetoworkspace, 9"
            "$mod+Shift, 0, movetoworkspace, 10"

          ];

          bindel = [
            # Sound
            ", XF86AudioRaiseVolume, exec, ${noctalia "volume increase"}"
            ", XF86AudioLowerVolume, exec, ${noctalia "volume decrease"}"
            # Screen Brightness
            ", XF86MonBrightnessDown, exec, ${noctalia "brightness decrease"}"
            ", XF86MonBrightnessUp, exec, ${noctalia "brightness increase"}"
          ];

          bindl = [
            # Sound
            ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
            ", XF86AudioMute, exec, ${noctalia "volume muteOutput"}"
            # Lock on lid close
            ", switch:Lid Switch, exec, hyprlock"
          ];

          bindm = [
            # Window Manipulation
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
    };
  };
}
