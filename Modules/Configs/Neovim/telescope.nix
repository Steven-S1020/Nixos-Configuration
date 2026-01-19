{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      type = "lua";
      config = /* lua */ ''
        ---[ Telescope ]---
        require('telescope').setup({
          defaults = {
            winblend = 10,
          },
        })

        map('n', '<leader>f', require'telescope.builtin'.find_files)
        map('n', '<leader>g', require'telescope.builtin'.live_grep)
      '';
    }
  ];
}
