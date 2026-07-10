{
  den.aspects.system._.networking.nixos = {
    networking.networkmanager.enable = true;
    services.openssh = {
      enable = true;
      openFirewall = true;
    };
  };
}
