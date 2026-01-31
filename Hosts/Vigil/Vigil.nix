{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    # Main Configurations
    ../../Modules

    # Home-Manager NixOS Module from Flake, enables home-manager
    inputs.home-manager.nixosModules.default

    # Vigil Hardware-Configuration
    ./hardware-configuration.nix
  ];

  # System Specific #
  ###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Vigil";

  # Disable desktop-specific services for headless Pi
  services.xserver.enable = lib.mkForce false;
  hardware.bluetooth.enable = lib.mkForce false;
  services.printing.enable = lib.mkForce false;

  # Enable DE Configurations:
  GNOME.enable = false;
  hyprland.enable = false;

  programs.steam.enable = false;

  # System Specific Packages
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    raspberrypifw
  ];
}
