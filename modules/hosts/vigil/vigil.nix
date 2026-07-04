{ __findFile, ... }:
{
  den.hosts.aarch64-linux.Vigil.users.steven = { };

  den.aspects.Vigil = {
    nixos =
      { pkgs, lib, ... }:
      {

        # Headless Pi — disable desktop services that common/stylix would enable
        services.xserver.enable = lib.mkForce false;
        hardware.bluetooth.enable = lib.mkForce false;
        services.printing.enable = lib.mkForce false;
        services.pipewire.enable = lib.mkForce false;
        security.rtkit.enable = lib.mkForce false;

        environment.systemPackages = with pkgs; [
          libraspberrypi
          raspberrypi-eeprom
          raspberrypifw
        ];

        fileSystems."/" = {
          # fix when on RP4
          device = "/dev/disk/by-uuid/7809ed61-0de1-48c0-864a-d8a9d97366ea";
          fsType = "ext4";
        };

      };

    includes = [
      <system/locale>
      <system/networking>
      <system/boot>
    ];
  };
}
