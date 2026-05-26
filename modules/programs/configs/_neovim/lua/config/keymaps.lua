local map = require 'utils.map'

-- Split navigation
map("n", "<leader>vv", ":vsplit<CR>")
map("n", "<leader>vs", ":split<CR>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- Sorting
map("v", "<C-s>", ":sort<CR>")
-- You know what I meant
map("n", "q:", ":q<CR>")
