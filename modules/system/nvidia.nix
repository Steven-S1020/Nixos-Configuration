{
  den.aspects.system._.nvidia.nixos =
    { config, ... }:
    {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
      };
    };
}
