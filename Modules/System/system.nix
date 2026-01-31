{
  pkgs,
  lib,
  ...
}:

{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # These are common across all hosts
  services.upower.enable = true;
  systemd.user.services.orca.wantedBy = lib.mkForce [ ];

  # Bootloader - common for x86 hosts (Azami & Deimos)
  # Will be overridden by Vigil's hardware-configuration
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # Networking - common to all
  networking.networkmanager.enable = lib.mkDefault true;
  time.timeZone = lib.mkDefault "America/New_York";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Xserver - only needed for desktop hosts
  services.xserver = {
    enable = lib.mkDefault true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = with pkgs; [ xterm ];
  };

  # Printing - common
  services.printing.enable = lib.mkDefault true;

  # Bluetooth - common
  hardware.bluetooth.enable = lib.mkDefault true;

  # Audio - common
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
