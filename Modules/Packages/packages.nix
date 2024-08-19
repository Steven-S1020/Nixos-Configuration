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
    colloid-gtk-theme
    colloid-icon-theme
    discord
    dunst
    fastfetch
    google-chrome
    hyprpaper
    libgcc
    libreoffice-qt
    lsd
    jdk
    nerdfonts
    python312
    rclone
    rofi-wayland
    vscode
  ];
  
  # Enable Packages
  programs.git.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.neovim.enable = true;
  programs.waybar.enable = true;

}

