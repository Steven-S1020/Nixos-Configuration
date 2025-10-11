{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-cmp;
      type = "lua";
      config # lua
        = ''
          local cmp = require'cmp'

          cmp.setup({
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            snippet = {
              expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert ({
               ['<Tab>'] = cmp.mapping.select_next_item(),
               ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources ({
              { name = 'nvim_lsp'},
              { name = 'buffer'},
              { name = 'path'},
              { name = 'ultisnips'},
            })
          })
        '';
    }
  ];
}
