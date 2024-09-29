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
    bat
    bitwarden-desktop
    colloid-icon-theme
    discord
    dunst
    fastfetch
    gnomeExtensions.open-bar
    google-chrome
    jdk
    libgcc
    libreoffice-qt
    lsd
    mkdev
    mysql84
    nerdfonts
    python312
    qFlipper
    rclone
    ripgrep
    vscode
    wl-clipboard
    xclip
    zulip
  ];
  
  # Enable Packages
  programs.git.enable = true;
  hardware.flipperzero.enable = true;

  services.fwupd.enable = true;
}

