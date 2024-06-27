# All Home-Manager Configurations

{ config, pkgs, lib, ... }:

{

  imports =
    [
      # Program-Conf
      ../Configs
      
      # DesktopEnv-Conf
      ../DesktopEnv-Conf
    ];


  # Home-Manager Users
  home-manager.users.steven =  { pkgs, ... }: {
    
    # Version of Nixos and Home-Manager
    home.stateVersion = "24.05";

  };
}

