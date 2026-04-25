{
  den.aspects.system._.services.nixos =
    { lib, pkgs, ... }:
    {
      services.orca.enable = false;
      services.speechd.enable = false;
    };
}
