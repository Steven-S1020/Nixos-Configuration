{ pkgs, ... }:

{
  # NixOS Options
  stylix = {

    enable = true;

    # Set Base16 Scheme
    # base16Scheme = ../../Assets/Base16-Schemes/Red-Flake.yaml;

    # Set Wallpaper
    image = ../../Assets/Wallpapers/Nasa.png;

    # Set Polarity
    polarity = "dark";

    # Set grub to use Wallpaper
    targets.grub.useImage = true;

    # Set Font
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        name = "FiraCode Nerd Font Mono";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 8;
        terminal = 10;
      };
>>>>>>> e3802dfd3dda96c3c0e9b4d574c241bdd26f9494
    };

    # Set Opacity
    opacity = {
      terminal = 0.9;
    };
  };

  # Home Manager Options
  home-manager.users.steven.stylix = {

    # Disable Neovim Theming
    targets.neovim.enable = false;
  };
}
