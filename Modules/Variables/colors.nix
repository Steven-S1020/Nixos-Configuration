{ lib, ... }:

with lib;
let
  colorType = types.submodule {
    options = {
      rgb = mkOption {
        type = types.str;
      };

      hex = mkOption {
        type = types.str;
      };

      ansi = mkOption {
        type = types.str;
      };
    };
  };

  parseColor =
    hex:
    let
      hexNoPrefix = removePrefix "#" hex;
      channels = {
        r = 1;
        g = 2;
        b = 3;
      };

      # Helper to extract the nth channel (n must be 1 indexed).
      hexPairOf = n: builtins.substring ((n - 1) * 2) 2 hexNoPrefix;
      # Helper that declares that some channel is the nth hex value.
      # e.g., given hex := ffee11, defineAsTOML r 1 := "r = 0xff"
      defineAsTOML = channel: index: "${channel} = 0x${hexPairOf index}";

      # Create the TOML document, parse it, and coerce the values from ints to strings.
      toml = lib.concatLines (lib.mapAttrsToList defineAsTOML channels);
      rgbVals = builtins.fromTOML toml;
      rgb = builtins.mapAttrs (_: builtins.toString) rgbVals;
    in
    {
      hex = hexNoPrefix;
      rgb = "${rgb.r}, ${rgb.g}, ${rgb.b}";
      ansi = "38;2;${rgb.r};${rgb.g};${rgb.b}";
    };
in
{
  options.colors = mkOption {
    type = types.attrsOf colorType;
    description = "Named color variables";
  };

  config.colors =
    let
      colors = {
        base = "272c33";
        black = "0d1013";
        darkred = "ee5858";
        lightgreen = "b3f6c0";
        purple = "a997df";
        red = "ac4242";
        text = "a0b0c5";
        yellow = "f9c784";
      };
    in
    builtins.mapAttrs (_: parseColor) colors;
}
