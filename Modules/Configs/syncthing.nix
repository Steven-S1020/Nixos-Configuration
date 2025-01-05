{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "steven";
    dataDir = "/home/steven/Documents";
    configDir = "/home/steven/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "Azami" = {
          id = "L5BJCJO-NRFMLQ6-2XAZWD5-S55I7YP-FAHSYQY-D5LC2KE-PXPUQD5-AFDULQS";
        };
        "Deimos" = {
          id = "3WWTFR5-FMQMOCV-XBTNULN-ZVPMWNX-OVBZ4HV-ZPOSNQ2-IMKKPTW-AOOJ4AK";
        };
      };

      folders = {
        "Documents" = {
          path = "/home/steven/Documents";
          devices = [
            "Azami"
            "Deimos"
          ];
        };

        "Code" = {
          path = "/home/steven/Code";
          devices = [
            "Azami"
            "Deimos"
          ];
        };

        "Pictures" = {
          path = "/home/steven/Pictures";
          devices = [
            "Azami"
            "Deimos"
          ];
        };
      };
    };
  };
}
