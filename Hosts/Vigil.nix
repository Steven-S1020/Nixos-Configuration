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

    # ../Modules
    inputs.home-manager.nixosModules.default

  ];

  # System Specific #
  ###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Vigil"; # Define your hostname.
  i18n.defaultLocale = "en_US.UTF-8";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";

  # Enable DE Configurations:
  # GNOME.enable = true;
  # hyprland.enable = true;

  programs.steam.enable = false;

  # System Specific Packages
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    raspberrypifw
  ];

  users.users.steven = {
    isNormalUser = true;
    description = "Steven";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Hardware Configuration #
  ##########################
  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  console.enable = true;

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "uas"
      "usb_storage"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    kernelParams = [
      "snd_bcm2835.enable_hdmi=1"
      "snd_bcm2835.enable_headphones=1"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      generic-extlinux-compatible = lib.mkForce false;
      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
      '';
      systemd-boot.enable = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6bd45f85-8acb-47d2-8cea-502ff6d0687d";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D254-5C7A";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/ddc4e858-9862-4809-8f15-8761b98d9fb9"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  hardware.enableRedistributableFirmware = true;
}
