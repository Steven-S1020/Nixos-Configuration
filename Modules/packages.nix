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
    google-chrome
    libgcc
    libreoffice-qt
    lsd
    nerdfonts
    python3
    teams-for-linux
    vscode
    wofi
  ];
  
  # Enable Packages
  programs.git.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.neovim.enable = true;
  programs.starship.enable = true;
  programs.waybar.enable = true;

}

