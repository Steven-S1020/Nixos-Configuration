-- Credit to github.com/ignorant05/dotfiles
return {
    owner = 'nvim-neo-tree',
    repo = 'neo-tree.nvim',
    deps = {
        { owner = 'nvim-lua',    repo = 'plenary.nvim' },
        { owner = 'nvim-tree',   repo = 'nvim-web-devicons' },
        { owner = 'MunifTanjim', repo = 'nui.nvim' },
        { owner = 'vhyrro',      repo = 'luarocks.nvim' },
        -- { owner = '3rd', repo = 'image.nvim' }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,
    config = function()
        local map = require 'utils.map'
        require 'neo-tree'.setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignore = false,
                },
            },

            window = {
                mappings = {
                    ['l'] = 'open',
                    ['h'] = 'shrink_dir',
                },
            },
            commands = {
                navigate_up_and_close = function(state)
                    local fs = require 'neo-tree.sources.filesystem'
                    local utils = require 'neo-tree.utils'
                    local parent_path, _ = utils.split_path(state.path)
                    if not utils.truthy(parent_path) then
                        return
                    end
                    local path_to_reveal = nil
                    local node = state.tree:get_node()
                    if node then
                        path_to_reveal = node:get_id()
                    end
                    if state.search_pattern then
                        fs.reset_search(state, false)
                    end
                    fs._navigate_internal(state, parent_path, path_to_reveal, function()
                        require 'neo-tree.sources.common.commands'.close_node(state)
                    end, false)
                end,
                shrink_dir = function(state)
                    local node = state.tree:get_node()
                    if require 'neo-tree.utils'.is_expandable(node) then
                        state.commands['toggle_directory'](state)
                    else
                        state.commands['close_node'](state)
                    end
                end,
            },
            event_handlers = {
                {
                    event = 'file_open_requested',
                    handler = function()
                        -- auto close
                        -- vim.cmd('Neotree close')
                        -- OR
                        require 'neo-tree.command'.execute({ action = 'close' })
                    end,
                },
            },
        })

        local function isFile(full_path)
            if vim.fn.isdirectory(full_path) == 0 then
                return vim.fn.fnamemodify(full_path, ':h')
            end
            return full_path
        end

        Neotree_is_open = false
        map('n', '<leader>e', function()
            if Neotree_is_open then
                vim.cmd('Neotree close')
            else
                -- local cwd = vim.fn.argv()[1]
                -- local fullPath = vim.fn.expand(cwd)
                local fullPath = vim.fn.getcwd()
                local path = isFile(fullPath)
                local current_file = vim.fn.expand('%:p')

                vim.cmd('Neotree float reveal=true dir=' .. path .. ' reveal_file=' .. current_file)
            end
            Neotree_is_open = not Neotree_is_open
        end, { noremap = false, silent = true })
    end,
}
