return {
    owner = "folke",
    repo = "snacks.nvim",
    immediate = true,
    config = function()
        local map = require("utils.map")
        ---@type snacks.Config
        require("snacks").setup({
            bigfile = { enabled = true },
            dashboard = {
                enabled = function()
                    local argc = vim.fn.argc()
                    if argc == 1 then
                        local arg = vim.fn.argv(0) --[[@as string]]
                        local stat = vim.loop.fs_stat(arg)
                        if stat and stat.type == "directory" then
                            return false
                        end
                    end
                    return true
                end,
                preset = {
                    header = [[
███╗   ██╗ ██████╗ ██████╗ ███╗   ███╗██╗███████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔═══██╗██╔══██╗████╗ ████║██║██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██████╔╝██╔████╔██║██║█████╗      ██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██║   ██║██╔══██╗██║╚██╔╝██║██║██╔══╝      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║╚██████╔╝██║  ██║██║ ╚═╝ ██║██║███████╗    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
                sections = {
                    { section = "header" },
                    { section = "keys",  gap = 1, padding = 1 },
                },
            },
            explorer = {
                enabled = true,
                cwd = vim.g.snacks_explorer_cwd or vim.fn.getcwd(),
            },
            indent = { enabled = true },
            image = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = {
                enabled = true,
                confirm = "tab",
                sources = {
                    explorer = {
                        auto_close = false,
                        jump = { close = false },
                        hidden = true,
                        on_change = function(picker)
                            vim.g.snacks_explorer_cwd = picker:cwd()
                        end,
                        win = {
                            list = {
                                keys = {
                                    ["d"] = { "explorer_delete", mode = { "n" } },
                                    ["<c-d>"] = { "explorer_delete", mode = { "n" } },
                                    ["f"] = { "explorer_menu", mode = { "n" } },
                                    ["<RightMouse>"] = { "explorer_menu", mode = { "n" } },
                                },
                            },
                        },
                        actions = {
                            explorer_delete = function(picker)
                                local item = picker:current()
                                if not item then
                                    Snacks.notify.warn("No item selected", { title = "Explorer" })
                                    return
                                end
                                local path = item.file
                                if not path or path == "" then
                                    Snacks.notify.warn("Cannot delete: no file path", { title = "Explorer" })
                                    return
                                end
                                local name = vim.fn.fnamemodify(path, ":t")
                                local choice = vim.fn.confirm("Delete " .. name .. "?", "&Yes\n&No", 2)
                                if choice == 1 then
                                    local stat = vim.loop.fs_stat(path)
                                    local ok, err
                                    if stat and stat.type == "directory" then
                                        ok, err = pcall(vim.fn.delete, path, "rf")
                                    else
                                        ok, err = pcall(vim.fn.delete, path)
                                    end
                                    if ok then
                                        Snacks.notify.info("Deleted: " .. name, { title = "Explorer" })
                                        picker:find({ on_done = function() end })
                                    else
                                        Snacks.notify.error("Failed to delete: " .. tostring(err), { title = "Explorer" })
                                    end
                                end
                            end,
                            explorer_menu = function(picker)
                                local item = picker:current()
                                if not item then return end

                                local actions = {
                                    { label = "Add file/dir", action = "explorer_add" },
                                    { label = "Rename",       action = "explorer_rename" },
                                    { label = "Copy",         action = "explorer_copy" },
                                    { label = "Paste",        action = "explorer_paste" },
                                    { label = "Move",         action = "explorer_move" },
                                    { label = "Delete",       action = "explorer_del" },
                                    { label = "Close dir",    action = "explorer_close" },
                                }

                                local choices = { "File Actions:" }
                                for i, a in ipairs(actions) do
                                    table.insert(choices, i .. ". " .. a.label)
                                end

                                local choice = vim.fn.inputlist(choices)
                                if choice > 0 and choice <= #actions then
                                    vim.schedule(function()
                                        picker:action(actions[choice].action)
                                    end)
                                end
                            end,
                        },
                    },
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true },
                },
            },
        })

        -- Keymaps
        map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
        map("n", "<leader>e", function() Snacks.explorer({ cwd = vim.g.snacks_explorer_cwd }) end,
            { desc = "File Explorer" })
        -- find
        map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
        map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
        map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
        -- grep
        map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
        map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
        map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
        map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
        -- search
        map("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
        map("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
        map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
        map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
        map("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
        map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
        map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
        map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
        map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
        map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
        map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
        map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
        map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
        map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
        map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
        map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
        map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
        -- LSP
        map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
        map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
        map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
        map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
        map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
        map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "Calls Incoming" })
        map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "Calls Outgoing" })
        map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
        map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
        -- other
        map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
        map("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
        map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
        map("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
        map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
        map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
    end,
}
