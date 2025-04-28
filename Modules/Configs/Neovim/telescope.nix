{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      type = "lua";
      config # lua
        = ''
          map('n', '<leader>f', require'telescope.builtin'.find_files)
          map('n', '<leader>g', require'telescope.builtin'.live_grep)
          vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
        '';
    }
  ];
}
