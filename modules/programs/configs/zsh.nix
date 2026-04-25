{
  den.aspects.programs._.zsh.homeManager =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        defaultKeymap = "viins";
        dirHashes = {
          cd = "$HOME/Code";
          dw = "$HOME/Downloads";
          nix = "/etc/nixos";
        };
        syntaxHighlighting = {
          enable = true;
          highlighters = [
            "main"
            "brackets"
            "regexp"
          ];
        };
        autosuggestion.enable = true;
        setOptions = [
          "auto_param_slash"
          "cdable_vars"
          "cd_silent"
          "correct"
        ];
        initContent = ''
          zstyle ':completion:*' insert-tab false
          bindkey "^f" fzf-history-widget
          bindkey "^a" autosuggest-accept
          fastfetch
        '';
        shellAliases = {
          cat = "bat";
          cff = "clear && ff";
          ff = "fastfetch";
          ls = "lsd";
          la = "ls -a";
          lla = "ls -la";
          lt = "ls --tree --group-dirs first";
          j = "just --justfile /etc/nixos/justfile";
        };
      };
    };
}
