{
  den.aspects.programs._.kitty.homeManager =
    { ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          cursor_trail = 1;
          dynamic_background_opacity = "yes";
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          hide_window_decorations = "yes";
        };
        shellIntegration.enableZshIntegration = true;
      };
    };

}
