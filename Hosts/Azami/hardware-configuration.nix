{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "23.11";
  # Hardware Configuration #
  ##########################

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
    kernelPatches = [
      {
        name = "rust-1.91-fix";
        patch = pkgs.writeText "rust-fix.patch" ''
          diff --recursive -u a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
          --- a/scripts/generate_rust_target.rs
          +++ b/scripts/generate_rust_target.rs
          @@ -225,7 +225,7 @@
                   ts.push("features", features);
                   ts.push("llvm-target", "x86_64-linux-gnu");
                   ts.push("supported-sanitizers", ["kcfi", "kernel-address"]);
          -        ts.push("target-pointer-width", "64");
          +        ts.push("target-pointer-width", 64);
               } else if cfg.has("X86_32") {
                   // This only works on UML, as i386 otherwise needs regparm support in rustc
                   if !cfg.has("UML") {
        '';
      }
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

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
