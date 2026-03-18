{
  den.aspects.system._.boot.nixos = {
    boot.loader.systemd-boot.enable      = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
