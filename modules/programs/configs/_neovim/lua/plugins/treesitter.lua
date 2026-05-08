return {
	owner = "nvim-treesitter",
	repo = "nvim-treesitter",
	immediate = true,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(event)
				require("nvim-treesitter").install({ "all" })
				-- manually exclude by filetype
				local bufnr = event.buf
				local ft = vim.bo[bufnr].filetype
				local excluded = {
					csv = true, -- Decisive.nvim provides a better parser
				}
				if excluded[ft] then
					return
				end

				pcall(vim.treesitter.start)
			end,
		})
	end,
}
