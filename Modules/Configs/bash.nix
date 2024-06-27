# Bash Configuration

{ config, pkgs, lib, ... }:

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
        cat = "bat";
        ls = "lsd";
	      la = "ls -a";
	      lla = "ls -la";
	      lt = "ls --tree --group-dirs first";
        create = "python /etc/nixos/Modules/Scripts/create.py";
	      clean-and-build = "sudo nix-collect-garbage -d; sudo nixos-rebuild switch";
	      update-and-build = "sudo nix-channel --update; sudo nixos-rebuild switch";
	      build = "sudo nixos-rebuild switch";

      };
    };
  };
}

