{
  __findFile,
  ...
}:
{
  den.aspects.programs._.graphical = {
    includes = [
      <programs/kitty>
    ];
    nixos =
      { pkgs, inputs', ... }:
      {
        environment.systemPackages = with pkgs; [
          # Desktop Apps
          inputs'.zen-browser.packages.default
          nautilus
          spotify
          vesktop
          zathura

          # Desktop Enviroment Utils
          colloid-icon-theme
          rose-pine-hyprcursor
          nerd-fonts.fira-code

          # Libreoffice
          libreoffice-qt
          hunspell
          hunspellDicts.en_US
        ];

        # Adding MS Fonts for School
        fonts.packages = with pkgs; [
          corefonts
        ];

        # Enable Packages
        hardware.flipperzero.enable = true;
      };
  };
}
