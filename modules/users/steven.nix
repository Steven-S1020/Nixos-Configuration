{ __findFile, den, ... }:
{
  den.aspects.steven = {
    includes = [
      <den/primary-user>
      (den._.user-shell "zsh")

      # included every host that steven is (i.e. All Hosts)
      <programs/cli>
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
        ];
      };
  };
}
