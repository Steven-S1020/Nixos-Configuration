{ __findFile, ... }:
{
  den.hosts.aarch64-linux.Vigil.users.steven = { };

  den.aspects.Vigil = {
    nixos = { pkgs, lib, ... }: {
      imports = [
        ../../Hosts/Vigil/hardware-configuration.nix
      ];

      # Headless Pi — disable desktop services that common/stylix would enable
      services.xserver.enable    = lib.mkForce false;
      hardware.bluetooth.enable  = lib.mkForce false;
      services.printing.enable   = lib.mkForce false;
      services.pipewire.enable   = lib.mkForce false;
      security.rtkit.enable      = lib.mkForce false;

      # Override stylix (pulled in by defaults) to disable graphical targets
      stylix.targets.gtk.enable     = lib.mkForce false;
      stylix.targets.gnome.enable   = lib.mkForce false;

      environment.systemPackages = with pkgs; [
        libraspberrypi
        raspberrypi-eeprom
        raspberrypifw
        bat fd lsd ripgrep unzip fastfetch
      ];

      programs.nh.enable = true;
    };

    includes = [
      <system/locale>
      <system/networking>
      # No common, no stylix, no audio, no bluetooth, no desktop
    ];
  };
}
