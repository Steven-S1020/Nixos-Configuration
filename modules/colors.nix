{ lib, ... }:
let
  # Parse "#RRGGBB" or "RRGGBB" → { hex, rgb, ansi }
  parseColor =
    rawHex:
    let
      hex = lib.removePrefix "#" rawHex;
      chan = start: builtins.fromTOML "v = 0x${builtins.substring start 2 hex}";
      r = toString (chan 0).v;
      g = toString (chan 2).v;
      b = toString (chan 4).v;
    in
    {
      inherit hex;
      rgb = "${r}, ${g}, ${b}";
      ansi = "38;2;${r};${g};${b}";
    };

  colorType = lib.types.submodule {
    options = {
      hex = lib.mkOption { type = lib.types.str; };
      rgb = lib.mkOption { type = lib.types.str; };
      ansi = lib.mkOption { type = lib.types.str; };
    };
  };
in
{
  # den.base.host adds typed options to every host's schema.
  # This makes `host.colors` available in context to any parametric
  # aspect function that takes `{ host, ... }`.
  #
  # Change the defaults here and every host picks them up automatically.
  # Individual hosts can override specific colors via:
  #   den.hosts.x86_64-linux.MyHost.colors.red = { hex = "ff0000"; ... };
  den.base.host = {
    options.colors = lib.mkOption {
      type = lib.types.attrsOf colorType;
      default = builtins.mapAttrs (_: parseColor) {
        base = "#272c33";
        red2 = "#f6a2a2";
        red1 = "#f27d7d";
        black = "#0d1013";
        red = "#ee5858";
        lightgreen = "#b3f6c0";
        purple = "#a997df";
        darkred = "#ac4242";
        blue = "#2c82b5";
        text = "#a0b0c5";
        yellow = "#f9c784";
        white = "#ffffff";
      };
      description = "Named colour palette. Available as host.colors in any parametric aspect.";
    };
  };
}
