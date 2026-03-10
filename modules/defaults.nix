{ den, lib, __findFile, ... }:
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
      <den/hostname>   
    ];
  };

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.ctx.hm-host.nixos.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  flake.den = den;
}
