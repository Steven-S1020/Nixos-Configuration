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
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
          inputs.nixos-hardware.nixosModules.microsoft-surface-common
        ];

        # MS Surface Specific
        hardware.microsoft-surface.kernelVersion = "stable";

        services = {
          upower.enable = true;
          iptsd.enable = true;
          power-profiles-daemon.enable = false;

          # thermald with Surface-appropriate config, --adaptive removed so
          # our thermal-conf.xml is actually respected
          thermald.enable = true;

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

        # Remove --adaptive flag so thermald uses our config instead of ignoring it
        systemd.services.thermald.serviceConfig.ExecStart =
          lib.mkForce "${pkgs.thermald}/sbin/thermald --no-daemon --dbus-enable --config-file /etc/thermald/thermal-conf.xml";

        # Graduated RAPL throttling via thermald - kicks in at 60°C using
        # x86_pkg_temp (confirmed present on this machine)
        environment.etc."thermald/thermal-conf.xml".text = ''
          <?xml version="1.0" encoding="UTF-8"?>
          <ThermalConfiguration>
            <Platform>
              <Name>Surface Laptop 5</Name>
              <ProductName>*</ProductName>
              <Preference>PERFORMANCE</Preference>
              <ThermalZones>
                <ThermalZone>
                  <Type>cpu</Type>
                  <TripPoints>
                    <TripPoint>
                      <SensorType>x86_pkg_temp</SensorType>
                      <Temperature>60000</Temperature>
                      <type>passive</type>
                      <ControlType>SEQUENTIAL</ControlType>
                      <CoolingDevice>
                        <index>1</index>
                        <type>rapl_controller</type>
                        <influence>100</influence>
                        <SamplingPeriod>5</SamplingPeriod>
                      </CoolingDevice>
                    </TripPoint>
                  </TripPoints>
                </ThermalZone>
              </ThermalZones>
            </Platform>
          </ThermalConfiguration>
        '';

        # Tell thermald to prefer rapl_controller over CPU frequency throttling
        environment.etc."thermald/thermal-cpu-cdev-order.xml".text = ''
          <CoolingDeviceOrder>
            <CoolingDevice>rapl_controller</CoolingDevice>
            <CoolingDevice>intel_pstate</CoolingDevice>
            <CoolingDevice>intel_powerclamp</CoolingDevice>
            <CoolingDevice>cpufreq</CoolingDevice>
            <CoolingDevice>Processor</CoolingDevice>
          </CoolingDeviceOrder>
        '';

        # Set Surface performance profile on boot
        systemd.services.surface-performance = {
          description = "Set Surface performance profile";
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.surface-control}/bin/surface profile set performance";
          };
        };

        # Static RAPL ceiling as a backstop — thermald does graduated control
        # above, this prevents any burst from ever exceeding 35W
        systemd.services.rapl-power-cap = {
          description = "Set CPU RAPL power limits";
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = pkgs.writeShellScript "rapl-cap" ''
              echo 25000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw
              echo 40000000 > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw
            '';
          };
        };

        # Switch surface profile on AC/battery events, restart thermald to reload config
        services.udev.extraRules = ''
          ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", \
            RUN+="${pkgs.surface-control}/bin/surface profile set performance", \
            RUN+="${pkgs.systemd}/bin/systemctl try-restart thermald", \
            RUN+="${pkgs.systemd}/bin/systemctl try-restart rapl-power-cap"

          ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", \
            RUN+="${pkgs.surface-control}/bin/surface profile set low-power", \
            RUN+="${pkgs.systemd}/bin/systemctl try-restart thermald"
        '';

        # Sysctl tweaks from linux-surface contrib/50-surface.conf
        boot.kernel.sysctl = {
          "kernel.nmi_watchdog" = 0;
          "vm.dirty_writeback_centisecs" = 1500;
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

          kernelModules = [ "kvm-intel" ];
          kernelParams = [
            "mem_sleep_default=deep"
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
