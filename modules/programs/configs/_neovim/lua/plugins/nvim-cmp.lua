return {
    owner = "hrsh7th",
    repo = "nvim-cmp",
    deps = {
        { owner = "kdheepak", repo = "cmp-latex-symbols" },
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<C-e>"] = cmp.mapping.abort(),
            },
            sources = {
                { name = "latex_symbols", option = { strategy = 0 } },
            },
        })
    end,
}
