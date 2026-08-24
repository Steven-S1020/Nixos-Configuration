return {
    owner = 'kylechui',
    repo = 'nvim-surround',
    config = function()
        local surround = require 'nvim-surround'
        surround.setup()
    end,
}
