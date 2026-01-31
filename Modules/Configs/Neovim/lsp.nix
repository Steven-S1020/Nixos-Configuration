{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''
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
        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('sqls')
        vim.lsp.enable('cssls')
        vim.lsp.enable('superhtml')

        -- React/JavaScript/TypeScript
        vim.lsp.enable('ts_ls')  -- or 'tsserver' depending on your nvim-lspconfig version

        -- Tailwind CSS
        vim.lsp.enable('tailwindcss')

        -- Optional: ESLint for linting
        vim.lsp.enable('eslint')

        -- Keybind for diagnostic window
        map('n', '<leader>d', function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end)
      '';
    }
  ];
}
