{
  den.aspects.system._.tailscale.nixos =
    { pkgs, ... }:
    {
      services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
      };

      networking.firewall.allowedUDPPorts = [ 41641 ];

      environment.systemPackages = with pkgs; [ tailscale ];
    };
}
