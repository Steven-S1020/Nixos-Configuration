{ pkgs, ... }:

{
  # NixOS Options
  stylix = {
    
    enable = true;
    
    # Set Base16 Scheme
    # base16Scheme = ../../Assets/Base16-Schemes/Red-Flake.yaml;

    # Set Wallpaper
    image = ../../Assets/Wallpapers/Tanjiro-Red.png;

    # Set Polarity
    polarity = "dark";

    # Set grub to use Wallpaper
    targets.grub.useImage = true;
    
    # Set Font
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font Mono";
      };
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
