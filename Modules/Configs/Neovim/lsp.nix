{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config # lua
        = ''
          ---- lsp config
          vim.lsp.enable('clangd')
          vim.lsp.enable('jdtls')
          vim.lsp.enable('nixd')
          vim.lsp.config('nixd', {
            settings = {
              formatting = {
                command = { "nixfmt" },
              },
            }
          })
          vim.lsp.enable('pyright')
          vim.lsp.enable('sqls')

          -- Keybind for diagnostic window
          map('n', '<leader>d', function()
            vim.diagnostic.open_float(nil, { focusable = false })
          end)
        '';
    }
  ];
}
