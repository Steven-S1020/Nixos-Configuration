{
  den.aspects.Vigil = {
    nixos = { config, lib, pkgs, modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [ "usbhid" "uas" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      hardware.deviceTree = lib.mkForce { enable = false; };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6bd45f85-8acb-47d2-8cea-502ff6d0687d";
        fsType = "btrfs";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/D254-5C7A";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/ddc4e858-9862-4809-8f15-8761b98d9fb9"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
  };
}
