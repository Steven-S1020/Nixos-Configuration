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
          base16Scheme = ../../../assets/Base16-Schemes/Nasa.yaml;
          image = ../../../assets/Wallpapers/Nasa.png;
          polarity = "dark";
          targets.grub.useWallpaper = true;
          targets.qt.enable = false;
          targets.nvf.enable = false;

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
              neovim.enable = false;
              nvf.enable = false;
              zathura.enable = false;
              hyprland.enable = false;
              starship.enable = false;
            };
          };
        }
      ))
    ];
  };
}
