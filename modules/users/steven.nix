{ __findFile, den, ... }:
{
  den.aspects.steven = {
    includes = [
      <den/primary-user>
      (den._.user-shell "zsh")

      # included every host that steven is (i.e. All Hosts)
      <programs/cli>
      # Program Aspects
      <programs/coding>
      <programs/graphical>

      # Desktop Aspects
      <desktop/hyprland>
      <desktop/noctalia>
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
        ];
      };
  };
}
