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
    colloid-gtk-theme
    colloid-icon-theme
    discord
    dunst
    fastfetch
    google-chrome
    libgcc
    mkdev
    libreoffice-qt
    lsd
    jdk
    gnomeExtensions.open-bar
    nerdfonts
    python312
    rclone
    vscode
    xclip
    wl-clipboard
    zulip
  ];
  
  # Enable Packages
  programs.git.enable = true;

  services.fwupd.enable = true;
}

