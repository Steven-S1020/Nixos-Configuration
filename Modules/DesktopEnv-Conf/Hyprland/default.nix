{
  config,
  lib,
  inputs,
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

        settings = {
          env = [
            "GDK_SCALE, 1"
            "XCURSOR_SIZE, 22"
          ];
          xwayland.force_zero_scaling = true;

          ### Input and Keybinds ###
          input = {
            kb_layout = "us,es";
            natural_scroll = false;
            numlock_by_default = true;

            touchpad = {
              natural_scroll = false;
            };
          };

          misc = {
            disable_hyprland_logo = true;
          };

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
        };
      };
    };
  };
}
