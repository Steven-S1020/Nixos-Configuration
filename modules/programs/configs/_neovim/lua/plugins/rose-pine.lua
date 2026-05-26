return {
    owner = "rose-pine",
    repo = "neovim",
    immediate = true,
    config = function()
        require 'rose-pine'.setup({
            variant = 'main',
        })
        vim.cmd.colorscheme 'rose-pine'
    end,
}
