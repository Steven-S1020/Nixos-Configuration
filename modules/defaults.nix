{ den, __findFile, ... }:
{
  den.default = {
    nixos.system.stateVersion = "24.11";
    nixos.nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixos.nixpkgs.config.allowUnfree = true;

    homeManager.home.stateVersion = "24.11";
    homeManager.nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    includes = [
      <den/define-user>
      (den.lib.take.exactly (
        { host }:
        {
          ${host.class}.networking.hostName = host.hostName;
        }
      ))
    ];
  };

  den.ctx.hm-host.nixos.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  flake.den = den;
}
