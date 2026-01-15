{
  pkgs,
  config,
  lib,
  modulesPath,
  inputs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ../Modules
    inputs.home-manager.nixosModules.default
    # ../Modules/System/NVFanControl.nix

  ];

  # System Specific #
  ###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Deimos"; # Define your hostname.
  GNOME.enable = false;
  hyprland.enable = true;
  home-manager.users.steven = {
    ##
  };

  # Disable HDMI before Ly starts, set resolution
  # systemd.services.ly-display-setup = {
  #   description = "Setup display for Ly greeter";
  #   before = [ "display-manager.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     User = "root";
  #     ExecStart = pkgs.writeShellScript "ly-setup" ''
  #       echo off > /sys/class/drm/card1-HDMI-A-1/status || true
  #       ${pkgs.fbset}/bin/fbset -xres 2560 -yres 1440 || true
  #     '';
  #   };
  # };

  # Enable HDMI after login
  # systemd.services.enable-hdmi-login = {
  #   description = "Enable HDMI after login";
  #   wantedBy = [ "openrgb.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #     ExecStart = pkgs.writeShellScript "hdmi-enable" ''
  #       echo on > /sys/class/drm/card1-HDMI-A-1/status || true
  #     '';
  #   };
  # };
  security.sudo.extraRules = [
    {
      users = [ "steven" ];
      commands = [
        {
          command = "${pkgs.coreutils}/bin/tee";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
      ];
    }
  ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bg = "0x00${config.colors.base.hex}";
      bigclock = "en";
      bigclock_12hr = true;
      border_fg = "0x00${config.colors.purple.hex}";
      box_title = "NixOS";
      brightness_down_key = "null";
      brightness_up_key = "null";
      cmatrix_fg = "0x00${config.colors.red.hex}";
      cmatrix_head_col = "0x01${config.colors.darkred.hex}";
      default_input = "password";
      fg = "0x00${config.colors.text.hex}";
      hide_version_string = true;
      # login_cmd = "echo on | sudo tee /sys/class/drm/card1-HDMI-A-1/status";
      # start_cmd = "echo off > /sys/class/drm/card1-HDMI-A-1/status || true && ${pkgs.fbset}/bin/fbset -xres 2560 -yres 1440 || true";
      text_in_center = true;
      vi_default_mode = "insert";
      vi_mode = true;
      xinitrc = "null";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  services.hardware.openrgb.enable = true;

  # System Specific Packages
  environment.systemPackages = with pkgs; [
    prismlauncher
    heroic
    satisfactorymodmanager
  ];

  # Stylix
  stylix.fonts.sizes = {
    applications = lib.mkForce 10;
    desktop = lib.mkForce 10;
    popups = lib.mkForce 8;
    terminal = lib.mkForce 12;
  };

  # Programs
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
        extraPkgs =
          pkgs: with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamemode
          ];
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  # File System
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2f631124-85ac-4a42-8b5d-b691e0d8a563";
    fsType = "ext4";
  };

  # Hardware Configuration #
  ##########################
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;
  };
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/709e6e62-6585-4766-85e7-3c06599ddf94";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/798B-035F";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
