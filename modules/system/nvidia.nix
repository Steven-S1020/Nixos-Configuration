{
  den.aspects.system._.nvidia.nixos = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable      = true;
    hardware.nvidia = {
      package               = null; # set by hardware-config via boot.kernelPackages
      modesetting.enable    = true;
      nvidiaSettings        = true;
      open                  = false;
      powerManagement.enable           = false;
      powerManagement.finegrained      = false;
    };
  };
}
