return {
    owner = "lervag",
    repo = "vimtex",
    config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_compiler_method = "latexmk"
    end,
}
