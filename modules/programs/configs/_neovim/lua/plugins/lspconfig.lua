return {
	owner = "neovim",
	repo = "nvim-lspconfig",
	config = function()
		local map = require("config.map")
		local servers = {
			bashls = true,
			clangd = true,
			basedpyright = true,
			jdtls = true,
			lua_ls = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							---@diagnostic disable-next-line: undefined-field
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
							path = { "lua/?.lua", "lua/?/init.lua" },
						},
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					})
				end,
				settings = { Lua = {} },
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
			vim.lsp.enable(name)
			if config ~= true then
				vim.lsp.config(name, config)
			end
		end

		-- Keybinds
		map("n", "<leader>lk", function()
			vim.lsp.buf.hover()
		end)
		map("n", "<leader>lf", function()
			vim.lsp.buf.definition()
		end)
		map("n", "<leader>d", function()
			vim.diagnostic.open_float()
		end)
		map("n", "<leader>lr", function()
			vim.lsp.buf.rename()
		end)
		map("n", "<leader>ln", function()
			vim.diagnostic.jump({ forward = true, count = 1 })
		end)
		map("n", "<leader>lp", function()
			vim.diagnostic.jump({ forward = false, count = 1 })
		end)
		map("n", "<leader>lb", function()
			vim.lsp.buf.format()
		end)

		-- Autocommands
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
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
