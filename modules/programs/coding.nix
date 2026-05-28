{
  __findFile,
  ...
}:
{
  den.aspects.programs._.coding = {
    includes = [
      <programs/nix-direnv>
      <programs/mkdev>
      <programs/julia>
    ];

    nixos =
      { pkgs, inputs', ... }:
      {
        environment.systemPackages = with pkgs; [
          # CLI Utils
          tokei
          inputs'.mkdev.packages.mkdev
        ];
      };
  };
}
