{ ... }:

{

  home-manager.users.steven = {
    programs.btop = {
      enable = true;

      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    xdg.desktopEntries = {
      btop = {
        type = "Application";
        name = "btop++";
        genericName = "System Monitor";
        comment = "Resource monitor that shows usage and stats for processor, memory, disks, network and processes";
        icon = "btop";
        exec = "kitty btop";
        terminal = false;
        categories = [
          "System"
          "Monitor"
          "ConsoleOnly"
        ];
      };
    };
  };
}
