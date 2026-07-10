-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup('LastCursorGroup', {})
vim.api.nvim_create_autocmd('BufReadPost', {
    group = last_cursor_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Set tabsize for *.nix
local group = vim.api.nvim_create_augroup("NixTabSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "nix",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank {
            higroup = 'IncSearch',
            timeout = 200,
        }
    end,
})

-- Create an autocommand group to prevent duplicate autocmds
local cursor_line_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

-- Enable cursorline in the active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = cursor_line_group,
    pattern = "*",
    callback = function()
        -- Skip special or prompt buffers if needed
        if vim.bo.buftype == "" then
            vim.wo.cursorline = true
        end
    end,
})

-- Disable cursorline in inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = cursor_line_group,
    pattern = "*",
    callback = function()
        vim.wo.cursorline = false
    end,
})
