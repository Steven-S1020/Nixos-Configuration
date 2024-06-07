{ pkgs, config, lib, ... }:

{
  imports = [
    ./Hypr-Modules
    ./hypr-modules.nix
    ./hyprland.nix
  ];
}
