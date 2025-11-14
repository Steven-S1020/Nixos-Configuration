{
  config,
  lib,
  ...
}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;

    home-manager.users.steven = {
      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          ##
        };
      };
    };
  };
}
