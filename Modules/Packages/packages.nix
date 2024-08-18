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
    base16preview
    bat
    btop
    discord
    dunst
    fastfetch
    flavours
    google-chrome
    hyprpaper
    libgcc
    libreoffice-qt
    lsd
    nerdfonts
    networkmanagerapplet
    python3
    rofi-wayland
    teams-for-linux
    vscode
  ];
  
  # Enable Packages
  programs.git.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.neovim.enable = true;
  programs.waybar.enable = true;

}

