{ pkgs, config, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprpaper.nix
    ./Neovim/neovim.nix
    ./kitty.nix
    ./stylix.nix
  ];
}
