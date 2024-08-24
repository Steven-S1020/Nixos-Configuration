# Bash Configuration

{ config, pkgs, lib, user, ... }:

{
  home-manager.users.steven = {
    programs.bash = {
      
      enable = true;

      # Command ran on open of Alacritty
      initExtra = ''
        fastfetch
      '';

      # Prompt Color
      bashrcExtra = ''
         PS1="\[\e[38;2;208;132;132m\][\[\e[38;2;172;66;66m\]\u@\h\[\e[38;2;208;132;132m\]] \w\n$ \[\e[0m\]" 
      '';
  
      # Shell Aliases 
      shellAliases = {
      	home = "cd ~";
        nix-home = "cd /etc/nixos";
        clear = "clear; fastfetch";
        cat = "bat";
        ls = "lsd";
        la = "ls -a";
        lla = "ls -la";
        lt = "ls --tree --group-dirs first";
        create = "python /etc/nixos/Modules/Scripts/create.py";
        clean-and-build = "sudo -u $(user) nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake /etc/nixos";
        build = "sudo nixos-rebuild switch --flake /etc/nixos";

      };
    };
  };
}

