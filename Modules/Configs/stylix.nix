{
  pkgs,
  ...
}:

{
  # NixOS Options
  stylix = {

    enable = true;

    # Set Base16 Scheme
    base16Scheme = ../../Assets/Base16-Schemes/Nasa.yaml;

    # Set Wallpaper
    image = ../../Assets/Wallpapers/Nasa.png;

    # Set Polarity
    polarity = "dark";

    # Set grub to use Wallpaper
    targets.grub.useWallpaper = true;

    # Set Font
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
    };

    cursor = {
      package = pkgs.rose-pine-hyprcursor;
      name = "rose-pine-hyprcursor";
      size = 22;
    };

    # Targets to Disable
    targets = {
      qt.enable = false;
    };
  };

  # Home Manager Options
  home-manager.users.steven.stylix = {

    # Disable Neovim Theming
    targets.neovim.enable = false;
    targets.zathura.enable = false;
    targets.hyprland.enable = false;
  };
}
