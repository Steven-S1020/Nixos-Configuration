{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = monokai-pro-nvim;
      type = "lua";
      config # lua
        = ''
          require('monokai-pro').setup({
            transparent_background = true,
            background_clear = {
              "float_win",
              "telescope",
              "TelescopeNormal",
              "TelescopeBorder",
              "TelescopePromptNormal",
              "TelescopePromptBorder",
              "TelescopeResultsNormal",
              "TelescopeResultsBorder",
              "TelescopePreviewNormal",
              "TelescopePreviewBorder",
            },
          })

          vim.cmd('colorscheme monokai-pro')
        '';
    }
  ];
}
