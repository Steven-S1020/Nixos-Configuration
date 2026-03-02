{ __findFile, den, ... }:
{
  den.aspects.programs._.cli = den.lib.parametric {
    includes = [
      <programs/bash>
      <programs/btop>
      <programs/fastfetch>
      <programs/fzf>
      <programs/git>
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
          unzip
          cbonsai
        ];

        # programs.zsh.enable = true;
        programs.nh.enable = true;
      };
  };
}
