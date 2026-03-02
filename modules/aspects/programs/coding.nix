{
  __findFile,
  inputs,
  den,
  ...
}:
{
  den.aspects.programs._.coding = den.lib.parametric {
    includes = [
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
                live-server
                inputs.mkdev.packages.${host.system}.mkdev
              ];
            };
        }
      ))
    ];
  };
}
