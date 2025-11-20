{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,

  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../Modules
    inputs.home-manager.nixosModules.default

  ];

  # System Specific #
  ###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Azami"; # Define your hostname.

  # Enable DE Configurations:
  GNOME.enable = true;
  hyprland.enable = true;

  programs.steam.enable = true;
  hardware.microsoft-surface.kernelVersion = "stable";

  # System Specific Packages
  environment.systemPackages = with pkgs; [
    surface-control
  ];

  # Stylix Specific #
  ###################
  stylix = {
    fonts.sizes = {
      applications = 8;
      desktop = 10;
      popups = 10;
      terminal = 8;
    };
  };

  # Hardware Configuration #
  ##########################
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelParams = [
    "acpi=force"
    "apm=power_off"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7809ed61-0de1-48c0-864a-d8a9d97366ea";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2D7C-36BD";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
