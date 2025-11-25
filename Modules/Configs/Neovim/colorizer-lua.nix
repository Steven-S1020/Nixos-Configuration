{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config # lua
        = ''
          ---[ Colorizer-Lua ]---
          require'colorizer'.setup({'*'}, {
            RGB = true,
            RRGGBB = true,
            RRGGBBAA = true,
            names = false,
            rgb_fn = true,
            hsl_fn = true,
          })
        '';
    }
  ];
}
