return {
    owner = 'emmanueltouzery',
    repo = 'decisive.nvim',
    config = function()
        -- Keybinds to enable the viewer
        require 'utils.map' ('n', '<leader>cca', function() require 'decisive'.align_csv({}) end)
        require 'utils.map' ('n', '<leader>ccA', function() require 'decisive'.align_csv_clear({}) end)
        require 'utils.map' ('n', '[c', require 'decisive'.align_csv_prev_col)
        require 'utils.map' ('n', ']c', require 'decisive'.align_csv_next_col)
    end
}
