{
  den.aspects.programs._.bash.homeManager =
    { ... }:
    {
      programs.bash = {
        enable = true;
        initExtra = "clear\nfastfetch\n";
        bashrcExtra = ''
          PS1="\[\e[37m\]|\[\e[38;2;172;66;66m\]\u@\h\[\e[37m\]|\e[38;2;172;66;66m\] \w \[\e[37m\]󱎃\n󰇜󰇜 \[\e[0m\]"
        '';
        shellAliases = {
          cat = "bat";
          cff = "clear && ff";
          ff = "fastfetch";
          la = "ls -a";
          lla = "ls -la";
          ls = "lsd";
          lt = "ls --tree --group-dirs first";
          just = "just --justfile /etc/nixos/justfile";
        };
      };
    };
}
