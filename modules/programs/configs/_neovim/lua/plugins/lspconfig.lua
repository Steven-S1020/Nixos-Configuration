return {
    owner = "neovim",
    repo = "nvim-lspconfig",
    config = function()
        local map = require("utils.map")

        local servers = {
            bashls = true,
            clangd = true,
            basedpyright = {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                            typeCheckingMode = "basic", -- less strict than default
                        },
                    },
                },
            },
            jdtls = true,
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                                vim.fn.stdpath("data") .. "/site/pack",
                            },
                            checkThirdParty = false,
                        },
                    },
                },
            },
            marksman = true,
            nil_ls = {
                settings = {
                    ["nil"] = {
                        formatting = {
                            command = { "nixfmt" },
                        },
                    },
                },
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

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then return end

                local function opts(desc)
                    return { noremap = true, silent = true, buffer = args.buf, desc = '[LSP]' .. desc }
                end

                map("n", "<leader>lk", vim.lsp.buf.hover, opts("Hover"))
                map("n", "<leader>lf", vim.lsp.buf.definition, opts("Definition"))
                map("n", "<leader>d", vim.diagnostic.open_float, opts("Diagnostics"))
                map("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename"))
                map("n", "<leader>ln", function() vim.diagnostic.jump({ forward = true, count = 1 }) end,
                    opts("Next diagnostic"))
                map("n", "<leader>lp", function() vim.diagnostic.jump({ forward = false, count = 1 }) end,
                    opts("Prev diagnostic"))
                map("n", "<leader>lb", vim.lsp.buf.format, opts("Format"))

                if client:supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            if not vim.tbl_contains({ "c", "cpp" }, vim.bo.filetype) then
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end
                        end,
                    })
                end
            end,
        })
    end,
}
