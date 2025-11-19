{
  config,
  lib,
  ...
}:

{
  imports = [
    ./binds.nix
    ./noctalia.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;

    home-manager.users.steven = {

      wayland.windowManager.hyprland = {
        enable = true;

        settings =
          let
            c = config.colors;
          in
          {
            env = [
              "GDK_SCALE, 2"
              "XCURSOR_SIZE, 22"
            ];
            xwayland.force_zero_scaling = true;

            ### Input and Keybinds ###
            input = {
              kb_layout = "us,es";
              natural_scroll = false;
              numlock_by_default = true;
            };

            general = {
              border_size = 3;
              gaps_in = 5;
              gaps_out = 10;
              "col.active_border" = "rgb(${c.red.hex})";
              "col.inactive_border" = "rgb(${c.base.hex})";
              resize_on_border = true;
            };
            decoration = {
              rounding = 10;
              active_opacity = 0.95;
              inactive_opacity = 0.90;
            };

            misc = {
              disable_hyprland_logo = true;
              mouse_move_enables_dpms = true;
              key_press_enables_dpms = true;
              animate_manual_resizes = true;
              background_color = "rgb(${c.darkred.hex})";
            };

            ecosystem = {
              no_update_news = true;
              no_donation_nag = true;
            };
          };
      };

      # Allow HM to Clobber Hyprland Config File
      xdg.configFile."hypr/hyprland.conf" = {
        force = true;
      };
    };
  };
}
