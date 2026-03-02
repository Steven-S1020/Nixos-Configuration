{
  inputs,
  den,
  ...
}:
{
  den.aspects.Azami = {
    nixos =
      {
        lib,
        pkgs,
        config,
        modulesPath,
        ...
      }:
      {
        # Hardware Configuration #

        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
          inputs.nixos-hardware.nixosModules.microsoft-surface-common
        ];

        # MS Surface Specific, see Brad-Hesson nixos-config.
        hardware.microsoft-surface.kernelVersion = "stable";
        services = {
          iptsd.enable = true;
          thermald.enable = true;
          power-profiles-daemon.enable = false;
          auto-cpufreq.enable = true;
          auto-cpufreq.settings = {
            battery = {
              governor = "powersave";
              turbo = "never";
            };
            charger = {
              governor = "performance";
              turbo = "auto";
            };
          };
        };

        boot = {
          extraModulePackages = [ ];

          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "thunderbolt"
              "nvme"
              "usb_storage"
              "sd_mod"
            ];
            kernelModules = [ ];
          };

          kernelModules = [ "kvm-amd" ];
          kernelParams = [
            "acpi=force"
            "apm=power_off"
          ];

        };

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

        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
