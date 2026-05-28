return {
    owner = "Vigemus",
    repo = "iron.nvim",
    config = function()
        local iron = require("iron.core")
        local map = require("utils.map")

        iron.setup({
            config = {
                scratch_repl = true,
                repl_definition = {
                    julia = {
                        command = { "julia" },
                    },
                },
                repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
            },
            highlight = {
                italic = true,
            },
            ignore_blank_lines = true,
        })

        map("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Start REPL" })
        map("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart REPL" })
        map("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "Focus REPL" })
        map("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide REPL" })
        map("n", "<leader>rb", "<C-w>p", { desc = "Back to previous window" })
        map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })
        map("n", "<leader>sl", require("iron.core").send_line, { desc = "Send line to REPL" })
        map("v", "<leader>sv", require("iron.core").visual_send, { desc = "Send selection to REPL" })
        map("n", "<leader>sf", require("iron.core").send_file, { desc = "Send file to REPL" })
        map("n", "<leader>sm", require("iron.core").send_mark, { desc = "Send mark to REPL" })
    end,
}
