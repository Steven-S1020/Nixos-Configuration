{ den, ... }:
{
  den.aspects.system._.dm = den.lib.parametric {
    nixos.services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        bigclock = "en";
        bigclock_12hr = true;
        box_title = "NixOS";
        brightness_up_key = "null";
        brightness_down_key = "null";
        default_input = "password";
        hide_version_string = true;
        text_in_center = true;
        vi_mode = true;
        vi_default_mode = "insert";
        xinitrc = "null";
      };
    };
  };
}
