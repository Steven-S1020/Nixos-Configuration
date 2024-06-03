# All User and System Packages Configuration

{ config, pkgs, lib, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User Configurations and Packages
  users.users.steven = {
    isNormalUser = true;
    description = "Steven";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    alacritty
    discord
    fastfetch
    git
    google-chrome
    libgcc
    libreoffice-qt
    lsd
    nerdfonts
    neovim
    python3
    vscode
  ];

}

