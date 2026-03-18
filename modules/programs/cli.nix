{ __findFile, den, ... }:
{
  den.aspects.programs._.cli = den.lib.parametric {
    includes = [
      <programs/bash>
      <programs/btop>
      <programs/fastfetch>
      <programs/fzf>
      <programs/git>
      <programs/mayhem>
      <programs/nvf>
      <programs/starship>
      <programs/zsh>
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          # CLI Utils
          bat
          fbset
          fd
          just
          lsd
          ripgrep
          nix-tree
          nvd
          unzip
          cbonsai
        ];

        programs.nh.enable = true;
      };
  };
}
