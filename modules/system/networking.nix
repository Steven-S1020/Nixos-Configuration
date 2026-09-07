{
  den.aspects.system._.networking = {
    nixos = {
      networking.networkmanager.enable = true;
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
      };
    };

    homeManager = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          Vigil = {
            hostname = "192.168.100.65";
            user = "steven";
            identityFile = "~/.ssh/Vigil_ed25519";
          };
        };
      };
    };
  };
}
