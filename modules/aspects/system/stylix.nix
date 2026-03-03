{ inputs, den, ... }:
{
  den.aspects.system._.stylix = den.lib.parametric {
    nixos =
      { pkgs, ... }:
      {
        # Import stylix NixOS module here — the only place it's imported
        imports = [
          inputs.stylix.nixosModules.stylix
        ];

        stylix = {
          enable = true;
          image = ../../../assets/Wallpapers/Tanjiro-Red.png;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
          override = {
            base08 = "c4a7e7";
            base0D = "eb6f92";
          };

          polarity = "dark";
          targets.grub.useWallpaper = true;

          fonts.monospace = {
            package = pkgs.nerd-fonts.fira-code;
            name = "FiraCode Nerd Font Mono";
          };
          cursor = {
            package = pkgs.rose-pine-hyprcursor;
            name = "rose-pine-hyprcursor";
            size = 22;
          };
        };
      };
    includes = [
      (den.lib.take.exactly (
        { host, user }:
        {
          # Opt-out stylix auto-theming for things we control manually
          homeManager = {
            stylix.targets = {
            };
          };
        }
      ))
    ];
  };
}
