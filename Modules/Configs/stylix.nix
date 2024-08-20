{ pkgs, ... }:

{
  # Enable Stylix
  stylix.enable = true;

  # Red-Flake base16 theme in Nix
  stylix.base16Scheme = {
    base00 = "131313";
    base01 = "525252";
    base02 = "646464";
    base03 = "a8a8a8";
    base04 = "bebebe";
    base05 = "e6e6e6";
    base06 = "ec625f";
    base07 = "ac4141";
    base08 = "a51e1e";
    base09 = "fe640b";
    base0A = "f8b93b";
    base0B = "93e25e";
    base0C = "81c8be";
    base0D = "4da1f0";
    base0E = "bd8aff";
    base0F = "dd7878";
  };
  
  # Set Wallpaper
  stylix.image = ../../Assets/nixos-red.png;
  
  # Set grub to use Wallpaper
  stylix.targets.grub.useImage = true;


}
