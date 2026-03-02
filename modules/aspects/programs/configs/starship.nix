{ den, ... }:
{
  den.aspects.programs._.starship = den.lib.parametric {
    includes = [
      (den.lib.take.atLeast (
        { host, ... }:
        {
          homeManager =
            { lib, ... }:
            let
              c = host.colors;
            in
            {
              programs.starship = {
                enable = true;

                settings = {
                  add_newline = false;
                  format = lib.concatStrings [
                    "[░▒▓](fg:#${c.darkred.hex})"
                    "[  ](bg:#${c.darkred.hex} fg:#${c.white.hex})"
                    "[](bg:#${c.red.hex} fg:#${c.darkred.hex})"
                    "$directory"
                    "[](bg:#${c.red1.hex} fg:#${c.red.hex})"
                    "$nix_shell"
                    "[](bg:#${c.red2.hex} fg:#${c.red1.hex})"
                    "$python"
                    "$c"
                    "$julia"
                    "$nodejs"
                    "$rlang"
                    "[](fg:#${c.red2.hex})"
                    "\n$character"
                  ];

                  directory = {
                    style = "fg:#${c.white.hex} bg:#${c.red.hex}";
                    format = "[ $path ]($style)";
                    truncation_length = 3;
                    truncation_symbol = "…/";
                    substitutions = {
                      "Documents" = "󰈙 ";
                      "Downloads" = " ";
                      "Music" = " ";
                      "Pictures" = " ";
                    };
                  };

                  nix_shell = {
                    symbol = "";
                    format = "[ $symbol $name ](fg:#${c.white.hex} bg:#${c.red1.hex})";
                    heuristic = false;
                  };

                  python = {
                    symbol = "󰌠";
                    format = "[ $symbol ($version) ](fg:#${c.black.hex} bg:#${c.red2.hex})";
                  };

                  nodejs = {
                    symbol = "󰎙";
                    format = "[ $symbol ($version) ](fg:#${c.black.hex} bg:#${c.red2.hex})";
                  };

                  rlang = {
                    symbol = "󰟔";
                    format = "[ $symbol ($version) ](fg:#${c.black.hex} bg:#${c.red2.hex})";
                  };

                  julia = {
                    symbol = "";
                    format = "[ $symbol ($version) ](fg:#${c.black.hex} bg:#${c.red2.hex})";
                  };

                  c = {
                    symbol = "";
                    format = "[ $symbol ($version) ](fg:#${c.black.hex} bg:#${c.red2.hex})";
                  };
                };
              };
            };
        }
      ))
    ];
  };
}
