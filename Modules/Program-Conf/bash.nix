# Bash Configuration

{ config, pkgs, lib, ... }:

{
  home-manager.users.steven = {
    programs.bash = {
      
      enable = true;

      # Command ran on open of Alacritty
      initExtra = "fastfetch";

      # Shell Aliases
      shellAliases = {
        ls = "lsd";
	la = "ls -a";
	lla = "ls -la";
	lt = "ls --tree";
        create = "sudo python /etc/nixos/Modules/Program-Conf/Script/create.py";
      };
    };
  };
}

