{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
      
      ../Modules
      inputs.home-manager.nixosModules.default

    ];

# System Specific #
###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Deimos"; # Define your hostname.
  GNOME.enable = true;

# Hardware Configuration #
##########################
hardware.graphics.enable = true;

services.xserver.videoDrivers = [ "nvidia" ];
hardware.nvidia = {
  modesetting.enable = true;

  powerManagement.enable = false;

  powerManagement.finegrained = false;

  open = false;

  nvidiaSettings = true;

  package = config.boot.kernelPackages.nvidiaPackages.stable;
};


}