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
          id = "";
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
