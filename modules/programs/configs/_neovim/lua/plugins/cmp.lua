return {
    owner = 'hrsh7th',
    repo = 'nvim-cmp',
    deps = {
        { owner = 'saadparwaiz1', repo = 'cmp_luasnip' },
        { owner = 'kdheepak',     repo = 'cmp-latex-symbols' },
        { owner = 'hrsh7th',      repo = 'cmp-nvim-lsp' },
        { owner = 'hrsh7th',      repo = 'cmp-path' },
        { owner = 'windwp',       repo = 'nvim-autopairs' }, -- Cross dependency, can be removed
    },
    config = function()
        local cmp = require 'cmp'
        local cmp_ap = require 'nvim-autopairs.completion.cmp'

        -- General Configuration
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    require 'luasnip'.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip' },
                { name = 'latex_symbols', option = { strategy = 0 } },
                { name = 'nvim_lsp' },
                { name = 'path' },
            })
        })

        -- Auto-add parentheses when completing a function
        cmp.event:on(
            'confirm_done',
            cmp_ap.on_confirm_done()
        )
    end
}
