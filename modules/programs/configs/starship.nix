{ den, ... }:
{
  den.aspects.programs._.starship = {
    includes = [
      (den.lib.take.atLeast (
        { host, ... }:
        {
          homeManager =
            { lib, ... }:
            {
              programs.starship = {
                enable = true;

                settings = {
                  add_newline = false;
                  format = lib.concatStrings [
                    "[░▒▓](fg:#e74b77)"
                    "[  ](bg:#e74b77 fg:#e0def4)"
                    "[](bg:#eb6f92 fg:#e74b77)"
                    "$directory"
                    "[](bg:#f093ae fg:#eb6f92)"
                    "$nix_shell"
                    "[](bg:#f5b7c9 fg:#f093ae)"
                    "$python"
                    "$c"
                    "$julia"
                    "$nodejs"
                    "$rlang"
                    "[](fg:#f5b7c9)"
                    "\n$character"
                  ];

                  directory = {
                    style = "fg:#e0def4 bg:#eb6f92";
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
                    format = "[ $symbol $name ](fg:#e0def4 bg:#f093ae)";
                    # heuristic = false;
                  };

                  python = {
                    symbol = "󰌠";
                    format = "[ $symbol ($version) ](fg:#191724 bg:#f5b7c9)";
                  };

                  nodejs = {
                    symbol = "󰎙";
                    format = "[ $symbol ($version) ](fg:#191724 bg:#f5b7c9)";
                  };

                  rlang = {
                    symbol = "󰟔";
                    format = "[ $symbol ($version) ](fg:#191724 bg:#f5b7c9)";
                  };

                  julia = {
                    symbol = "";
                    format = "[ $symbol ($version) ](fg:#191724 bg:#f5b7c9)";
                  };

                  c = {
                    symbol = "";
                    format = "[ $symbol ($version) ](fg:#191724 bg:#f5b7c9)";
                  };
                };
              };
            };
        }
      ))
    ];
  };
}
