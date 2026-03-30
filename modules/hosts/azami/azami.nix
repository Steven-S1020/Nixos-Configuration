{
  __findFile,
  ...
}:
{
  den.hosts.x86_64-linux.Azami.users.steven = { };

  den.aspects.Azami = {

    includes = [

      # System Aspects
      <system/audio>
      <system/bluetooth>
      <system/boot>
      <system/dm>
      <system/locale>
      <system/networking>
      <system/printing>
      <system/stylix>
      <system/syncthing>
    ];

    nixos =
      { lib, ... }:
      {
        programs.steam.enable = true;
        services.upower.enable = true;
        stylix.fonts.sizes = lib.mkForce {
          applications = 8;
          desktop = 10;
          popups = 10;
          terminal = 10;
        };
      };
  };
}
