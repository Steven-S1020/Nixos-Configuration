# All User and System Packages Configuration

{ pkgs, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User Configurations and Packages
  users.users.steven = {
    isNormalUser = true;
    description = "Steven";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # CLI Utilites
    bat
    fastfetch
    lsd
    mkdev
    mysql84
    rclone
    ripgrep

    # Desktop Applications
    bitwarden-desktop
    google-chrome
    libreoffice-qt
    qFlipper
    vscode

    # Coding
    jdk
    libgcc
    python312

    # Desktop Environment Utilites
    colloid-icon-theme
    dunst
    gnomeExtensions.open-bar
    nerdfonts
    wl-clipboard
    xclip

  ];
  
  # Enable Packages
  programs.git.enable = true;
  hardware.flipperzero.enable = true;

}

