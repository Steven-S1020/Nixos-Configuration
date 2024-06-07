{ pkgs, config, lib, ... }:

{
  imports = [
    #./rofi-wayland.nix
    ./waybar.nix
  ];
}
