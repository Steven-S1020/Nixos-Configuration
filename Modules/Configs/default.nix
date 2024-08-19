{ pkgs, config, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprpaper.nix
    ./neovim.nix
#    ./rclone.nix
  ];
}
