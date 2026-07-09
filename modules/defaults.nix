{
  den,
  __findFile,
  ...
}:
{
  den.default = {
    nixos.system.stateVersion = "26.05";
    nixos.nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixos.nixpkgs.config.allowUnfree = true;

    homeManager.home.stateVersion = "26.05";
    homeManager.nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    includes = [
      <den/define-user>
      <den/hostname>
      den._.inputs'
    ];
  };

  den.schema.user =
    { lib, ... }:
    {
      config.classes = lib.mkDefault [ "homeManager" ];
    };
  den.schema.host = { host, lib, ... }: {
    options.minimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether host ${host.name} should be provisioned with a minimal footprint";
    };
  };
  # Uncomment when needed for debug.
  # flake.den = den;
}
