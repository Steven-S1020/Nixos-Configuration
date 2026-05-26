{
  den.aspects.programs._.neovim = {
    nixos =
      { pkgs, ... }:
      {
        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          defaultEditor = true;
          withPython3 = true;
          withRuby = false;
        };

        environment = {
          sessionVariables.EDITOR = "nvim";
          systemPackages = with pkgs; [
            ## LSP
            basedpyright # Python
            bash-language-server # Bash/Shell/Zsh
            clang-tools # C/C++/Obj-C
            jdt-language-server # Java
            lua-language-server # Lua
            marksman # Markdown
            nil # Nix
            rPackages.languageserver # R
            sqls # SQL
            superhtml # HTML
            typescript-language-server # TypeScript/JavaScript
            vscode-css-languageserver # CSS

            ## Other
            gcc
            tree-sitter
          ];
        };
      };

    homeManager =
      { config, ... }:
      {
        xdg.configFile."nvim".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/programs/configs/_neovim";
      };
  };
}
