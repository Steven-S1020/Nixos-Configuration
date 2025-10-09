{ ... }:

{
  home-manager.users.steven = {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_trail = 1;

        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        hide_window_decorations = "yes";
      };
    };
  };
}
