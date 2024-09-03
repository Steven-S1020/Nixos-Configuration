{ ... }:

{
  # NixOS Options
  stylix = {

    enable = true;
    
    # Set Base16 Scheme
    base16Scheme = ../../Assets/Base16-Schemes/Red-Flake.yaml;
    # Set Wallpaper
    image = ../../Assets/nixos-red.png;

    # Set Polarity
    polarity = "dark";

    # Set grub to use Wallpaper
    targets.grub.useImage = true;

    # Set Opacity 
    opacity = {
      terminal = 0.8;
    };
    
  };

  # Home Manager Options
  home-manager.users.steven.stylix = {

    # Disable Neovim Theming
    targets.neovim.enable = false;

  };
}
