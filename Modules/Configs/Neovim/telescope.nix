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
          require('telescope').setup({
            defaults = {
              winblend = 10,
            }
          })

          map('n', '<leader>f', require'telescope.builtin'.find_files)
          map('n', '<leader>g', require'telescope.builtin'.live_grep)
          -- Transparent background
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
        '';
    }
  ];
}
