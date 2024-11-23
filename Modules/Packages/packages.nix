# All User and System Packages Configuration

{ pkgs, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User Configurations and Packages
  users.users.steven = {
    isNormalUser = true;
    description = "Steven";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # CLI Utilites
    bat
    fastfetch
    fd
    glow
    lsd
    mkdev
    mysql84
    nixfmt-rfc-style
    rclone
    ripgrep

    # Desktop Applications
    brave
    bitwarden-desktop
    google-chrome
    libreoffice-qt
    qFlipper
    vesktop
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
