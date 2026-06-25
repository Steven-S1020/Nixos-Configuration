return {
    owner = "Vigemus",
    repo = "iron.nvim",
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")
        local common = require 'iron.fts.common'

        iron.setup({
            config = {
                scratch_repl = true,

                repl_definition = {
                    julia = {
                        command = { "julia-env" },
                        format = common.bracketed_paste,
                    },
                },

                repl_open_cmd = view.split.vertical.botright(0.4),
            },

            keymaps = {
                toggle_repl = "<leader>rt",
                restart_repl = "<leader>rr",

                send_line = "<leader>sl",
                visual_send = "<leader>sv",
                send_motion = "<leader>sm",
                send_paragraph = "<leader>sp",
                send_file = "<leader>sf",

                interrupt = "<leader>ri",
                exit = "<space>rq",
            },

            ignore_blank_lines = true,
        })

        vim.keymap.set("n", "<leader>rf", function()
            vim.cmd("IronFocus")
            vim.cmd("startinsert")
        end, { desc = "Focus REPL" })

        vim.keymap.set("t", "<Esc>", "<C-\\><C-n>",
            { desc = "Terminal normal mode" })
    end,
}
