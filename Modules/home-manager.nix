# All Home-Manager Configurations

{ config, pkgs, lib, ... }:

{

  imports =
    [
      # Program-Conf
      ./Program-Conf/alacritty.nix
      ./Program-Conf/bash.nix
      ./Program-Conf/fastfetch.nix
      ./Program-Conf/git.nix

      # DesktopEnv-Conf
      ./DesktopEnv-Conf/hyprland.nix
    ];


  # Home-Manager Users
  home-manager.users.steven =  { pkgs, ... }: {
    
    # Version of Nixos and Home-Manager
    home.stateVersion = "24.05";

  };
}

