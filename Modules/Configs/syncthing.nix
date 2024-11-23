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
          id = "I4Y36TF-F6YTDFP-XS5F2IJ-6FR7UTK-PDCZIML-7OWPOTT-YFOS6KJ-ZMTZXAC";
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
