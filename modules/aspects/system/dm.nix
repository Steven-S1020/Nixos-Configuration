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

    includes = [
      (den.lib.take.exactly (
        { host }:
        let
          c = host.colors;
        in
        {
          nixos.services.displayManager.ly.settings = {
            fg = "0x00${c.text.hex}";
            bg = "0x00${c.base.hex}";
            border_fg = "0x00${c.purple.hex}";
            cmatrix_fg = "0x00${c.red.hex}";
            cmatrix_head_col = "0x00${c.darkred.hex}";
          };
        }
      ))
    ];
  };
}
