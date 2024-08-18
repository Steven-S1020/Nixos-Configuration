{ pkgs, config, lib, ... }:

{
  imports = [
    ./Hyprland
    ./GNOME
  ];

  services.xserver.displayManager.gdm.enable = true;
}
