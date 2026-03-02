{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;

in
{
  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        enableLuaLoader = true;
        hideSearchHighlight = true;
        searchCase = "smart";

        options = {
          mouse = "a";
          signcolumn = "no";
          scrolloff = 8;
          swapfile = false;

          softtabstop = 2;
          shiftwidth = 2;
          tabstop = 2;
          expandtab = true;
          smartindent = true;
          updatetime = 50;
        };

        clipboard = {
          enable = true;
          providers = {
            wl-copy.enable = true;
            xclip.enable = true;
          };
        };

        spellcheck = {
          enable = true;
          languages = [
            "en"
          ];
        };
      };
    };
  };
}
