{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "25.11";
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
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "uas"
        "usb_storage"
      ];

      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
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

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  hardware.enableRedistributableFirmware = true;
}
