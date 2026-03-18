{
  den.aspects.system._.minimal.nixos =
    { lib, pkgs, ... }:
    {
      documentation.doc.enable = false;
      documentation.info.enable = false;

      environment.defaultPackages = lib.mkForce [ ];

      programs.thunderbird.packages = pkgs.thunderbird.ovverride {
        speechSynthesisSupport = false;
      };

      security.wrapperDirSize = "10M";

      services.orca.enable = false;
      services.speechd.enable = false;
    };
}
