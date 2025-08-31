# All User and System Packages Configuration

{ pkgs, inputs, ... }:

{
  # Default Imports
  imports = [
    ./Custom-Packages
  ];

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
    du-dust
    fastfetch
    fd
    just
    lsd
    ripgrep
    tokei

    # Desktop Applications
    bitwarden-desktop
    brave
    google-chrome
    heroic
    inputs.zen-browser.packages.x86_64-linux.default
    libreoffice-qt
    prismlauncher
    qFlipper
    spotify
    vesktop

    # Coding
    inputs.mkdev.packages.x86_64-linux.mkdev
    jdk
    libgcc
    mars-mips
    python313

    # Desktop Environment Utilites
    colloid-icon-theme
    gnomeExtensions.hide-top-bar
    hunspell
    hunspellDicts.en_US
    nerd-fonts.fira-code
    wl-clipboard
    xclip
  ];

  # Adding MS Fonts for school
  fonts.packages = with pkgs; [
    corefonts
  ];

  # Enable Packages
  hardware.flipperzero.enable = true;
  programs.git.enable = true;
  programs.nh.enable = true;

}
