{ __findFile, inputs, ... }:
{
  den.hosts.aarch64-linux.Vigil = {
    users.steven = { };
    minimal = true;
  };

  den.aspects.Vigil = {
    nixos =
      { pkgs, lib, ... }:
      {
        # Bluetooth: unused, and UART attach was spamming boot logs — kill at the driver level
        boot.blacklistedKernelModules = [ "hci_uart" ];
        hardware.bluetooth.enable = lib.mkForce false;

        # Headless Pi — disable desktop services that common/stylix would enable
        services.xserver.enable = lib.mkForce false;
        services.printing.enable = lib.mkForce false;
        services.pipewire.enable = lib.mkForce false;
        security.rtkit.enable = lib.mkForce false;

        # Storage health — NVMe/USB, not SD card
        services.fstrim.enable = true;
        services.btrfs.autoScrub = {
          enable = true;
          interval = "monthly";
          fileSystems = [ "/" ];
        };

        # Bound journal growth on a headless box
        services.journald.extraConfig = ''
          SystemMaxUse=200M
        '';

        # Hardware watchdog — auto-reboot on kernel hang, since it's unattended
        systemd.settings.Manager.RuntimeWatchdogSec = "30";

        # Keep RPi bootloader EEPROM current — matters for USB/NVMe boot reliability
        systemd.services.rpi-eeprom-update = {
          description = "Check/apply RPi bootloader EEPROM updates";
          serviceConfig.Type = "oneshot";
          script = "${pkgs.raspberrypi-eeprom}/bin/rpi-eeprom-update -a";
        };
        systemd.timers.rpi-eeprom-update = {
          wantedBy = [ "timers.target" ];
          timerConfig.OnCalendar = "monthly";
        };

        environment.systemPackages = with pkgs; [
          libraspberrypi
          raspberrypi-eeprom
          raspberrypifw
        ];

      };

    includes = [
      <system/locale>
      <system/networking>
      <system/boot>
    ];
  };
}
