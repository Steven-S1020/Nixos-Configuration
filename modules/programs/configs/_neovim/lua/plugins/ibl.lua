return {
    owner = 'lukas-reineke',
    repo = 'indent-blankline.nvim',
    config = function()
        require 'ibl'.setup {
            scope = { enabled = false }
        }
    end
}
