return {
    owner = "neovim",
    repo = "nvim-lspconfig",
    config = function()
        local map = require 'utils.map'
        local hostname = require 'utils.hostname'
        local servers = {
            bashls = true,
            clangd = true,
            pyright = true,
            jdtls = true,
            jetls = {
                cmd = { "jetls", "--threads=auto", "--", "serve" },
                filetypes = { "julia" },
                root_markers = { "Project.toml" },
            },
            -- Credit to github.com/4jamesccraven/dotfiles
            lua_ls = {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            },
            marksman = true,
            -- Credit to github.com/4jamesccraven/dotfiles
            nixd = {
                settings = {
                    nixd = {
                        formatting = {
                            command = { 'nixfmt' }
                        },
                        nixpkgs = {
                            expr = 'import <nixpkgs> { }'
                        },
                        options = {
                            nixos = {
                                expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.' ..
                                    hostname .. '.options',
                            },
                            home_manager = {
                                expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.' ..
                                    hostname .. '.options.home-manager.users.type.getSubOptions []',
                            },
                        }
                    }
                }
            },
            r_language_server = true,
            sqls = true,
            superhtml = true,
            ts_ls = true,
            cssls = true,
        }

        for name, config in pairs(servers) do
            if config ~= true then
                vim.lsp.config(name, config)
            end
            vim.lsp.enable(name)
        end

        -- Keybinds
        map('n', '<leader>lk', function() vim.lsp.buf.hover() end)
        map('n', '<leader>lf', function() vim.lsp.buf.definition() end)
        map('n', '<leader>d', function() vim.diagnostic.open_float() end)
        map('n', '<leader>lr', function() vim.lsp.buf.rename() end)
        map('n', '<leader>ln', function() vim.diagnostic.jump({ forward = true, count = 1 }) end)
        map('n', '<leader>lp', function() vim.diagnostic.jump({ forward = false, count = 1 }) end)
        map('n', '<leader>lb', function() vim.lsp.buf.format() end)

        -- Autocommands
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                -- Format on save if supported
                if client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end
            end,
        })
    end,
}
