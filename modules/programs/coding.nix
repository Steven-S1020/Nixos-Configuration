{
  __findFile,
  ...
}:
{
  den.aspects.programs._.coding = {
    includes = [
      <programs/nix-direnv>
      <programs/mkdev>
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
