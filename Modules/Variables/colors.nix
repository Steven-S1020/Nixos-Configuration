{ lib, ... }:

with lib;
let
  hexToRgbAnsi =
    hex:
    let
      h = removePrefix "#" hex;
      parse = i: builtins.parseInt (builtins.substring i 2 h) 16;
      r = parse 0;
      g = parse 2;
      b = parse 4;
    in
    {
      rgb = "${r}, ${g}, ${b}";
      ansi = "38;2;${r};${g};${b}";
    };

  colorType = types.submodule (
    { config, ... }:
    {
      options = {
        hex = mkOption {
          type = types.str;
        };

        rgb = mkOption {
          type = types.str;
          readOnly = true;
          default = hexToRgbAnsi config.hex.rgb;
        };

        ansi = mkOption {
          type = types.str;
          readOnly = true;
          default = hexToRgbAnsi config.hex.ansi;
        };
      };

      config =
        let
          derived = hexToRgbAnsi config.hex;
        in
        {
          rgb = derived.rgb;
          ansi = derived.ansi;
        };
    }
  );
in
{
  options.colors = mkOption {
    type = types.attrsOf colorType;
    description = "Named colour variables";
  };

  config.colors = {
    base.hex = "272c33";
    black.hex = "0d1013";
    darkred.hex = "ee5858";
    lightgreen.hex = "b3f6c0";
    purple.hex = "a997df";
    red.hex = "ac4242";
    text.hex = "a0b0c5";
    yellow.hex = "f9c784";
  };
}
