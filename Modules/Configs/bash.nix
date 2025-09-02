# Bash Configuration

{ ... }:

{
  home-manager.users.steven = {
    programs.bash = {

      enable = true;

      # Command ran on open Shell
      initExtra = ''
        fastfetch
      '';

      # Prompt Color
      bashrcExtra = ''
        PS1="\[\e[37m\]|\[\e[38;2;172;66;66m\]\u@\h\[\e[37m\]|\e[38;2;172;66;66m\] \w \[\e[37m\]󱎃\n󰇜󰇜 \[\e[0m\]" 
      '';

      # Shell Aliases
      shellAliases = {
        cat = "bat";
        cff = "clear && ff";
        ff = "fastfetch";
        la = "ls -a";
        lla = "ls -la";
        ls = "lsd";
        lt = "ls --tree --group-dirs first";
        nix-home = "cd /etc/nixos";
        just = "just --justfile /etc/nixos/justfile";
      };
    };
  };
}
