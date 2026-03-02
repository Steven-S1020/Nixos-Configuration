{
  inputs,
  den,
  __findFile,
  ...
}:
{
  den.aspects.programs._.graphical = den.lib.parametric {
    includes = [
      <programs/kitty>
      (den.lib.take.atLeast (
        { host, ... }:
        {
          nixos =
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                # Desktop Apps
                bitwarden-desktop
                inputs.zen-browser.packages.${host.system}.default
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
        }
      ))
    ];
  };
}
