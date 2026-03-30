{
  __findFile,
  inputs,
  den,
  ...
}:
{
  den.aspects.programs._.coding = {
    includes = [
      <programs/nix-direnv>
      <programs/mkdev>
      (den.lib.take.atLeast (
        { host, ... }:
        {
          nixos =
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                # CLI Utils
                tokei
                inputs.mkdev.packages.${host.system}.mkdev
              ];
            };
        }
      ))
    ];
  };
}
