{
  __findFile,
  ...
}:
{
  den.hosts.x86_64-linux.Deimos.users.steven = { };

  den.aspects.Deimos = {

    includes = [
      # Program Aspects
      <programs/coding>
      <programs/graphical>

      # Desktop Aspects
      <desktop/hyprland>
      <desktop/noctalia>

      # System Aspects
      <system/boot>
      <system/dm>
      <system/locale>
      <system/networking>
      <system/audio>
      <system/bluetooth>
      <system/stylix>
    ];
    nixos =
      { pkgs, lib, ... }:
      {

        services.hardware.openrgb.enable = true;
        environment.systemPackages = with pkgs; [
          prismlauncher
          heroic
          satisfactorymodmanager
        ];

        stylix.fonts.sizes = lib.mkForce {
          applications = 10;
          desktop = 10;
          popups = 8;
          terminal = 12;
        };

        programs.steam = {
          enable = true;
          gamescopeSession.enable = true;
          packages = pkgs.steam.override {
            extraLibraries = pkgs: [ pkgs.libxcb ];
            extraPkgs =
              pkgs: with pkgs; [
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
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
  };
}
