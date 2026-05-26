---- Diagnostics Config
---- repo: https://gitlab.com/theblackdon/normie-nvim.git

local M = {}

local diagnostic_signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

M.setup = function()
    vim.diagnostic.config({
        -- Show signs in the gutter
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
                [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
                [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
                [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            },
            linehl = false,
        },
        -- Show virtual text next to error (inline diagnostics)
        virtual_text = {
            prefix = '●',
            spacing = 2,
            severity = {
                min = vim.diagnostic.severity.HINT, -- Show all severity levels
            },
        },
        -- Underline errors
        underline = true,
        -- Show diagnostic in floating window on hover
        float = {
            source = "always",
        },
        severity_sort = true,
        update_in_insert = false,
    })
end

return M
