{ lib, ... }:
{
  den.aspects.programs._.neovim = 
  { host, ... }:  
  {
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
          systemPackages = lib.optionals (!host.minimal) (with pkgs; [
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
            texlive.combined.scheme-full
          ]);
        };
      };

    homeManager =
      { config, ... }:
      {
        xdg.configFile."nvim".source =
          config.lib.file.mkOutOfStoreSymlink (
            if host.minimal
            then "/etc/nixos/modules/programs/configs/_neovim-minimal"
            else "/etc/nixos/modules/programs/configs/_neovim"
          );
      };
  };
}
