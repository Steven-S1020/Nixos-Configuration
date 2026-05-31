-- vim.opt shorthand
local o = vim.opt

-- Basic Settings
o.number = true
o.relativenumber = true
o.cursorline = true
o.scrolloff = 10
o.sidescrolloff = 8
o.wrap = false
o.cmdheight = 1
o.spelllang = { 'en' }

-- Tabbing / Indentation
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.grepprg = 'rg --vimgrep'
o.grepformat = '%f:%l:%c:%m'

-- Search Settings
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- Visual Setings
o.termguicolors = true
o.signcolumn = 'yes'
o.showmatch = true
o.matchtime = 2
o.completeopt = 'menuone,noinsert,noselect'
o.showmode = false
o.pumheight = 10
o.pumblend = 10
o.winblend = 0
o.conceallevel = 0
o.concealcursor = ''
o.lazyredraw = false
o.redrawtime = 10000
o.maxmempattern = 20000
o.synmaxcol = 300

-- File Handling
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 0
o.autoread = true
o.autowrite = false
o.diffopt:append 'vertical'
o.diffopt:append 'algorithm:patience'
o.diffopt:append 'linematch:60'

-- Set undo directory and ensure it exists
local undodir = '~/.local/share/nvim/undodir'
o.undodir = vim.fn.expand(undodir)
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
    vim.fn.mkdir(undodir_path, 'p')
end

-- Behavior Settings
o.errorbells = false
o.backspace = 'indent,eol,start'
o.autochdir = false
o.iskeyword:append '-'
o.path:append '**'
o.selection = 'inclusive'
o.mouse = 'a'
o.clipboard:append 'unnamedplus'
o.modifiable = true
o.encoding = 'UTF-8'
o.wildmenu = true
o.wildmode = 'longest:full,full'
o.wildignorecase = true
o.showtabline = 2

-- Cursor Settings
o.guicursor = {
    'n-v-c:block',
    'i-ci-ve-t:ver25',
    'r-cr:hor20',
    'o:hor50',
    'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'sm:block-blinkwait175-blinkoff150-blinkon175',
}

-- Folding Setings
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldlevel = 99

-- Split Behavior
o.splitbelow = true
o.splitright = true

-- List Characters
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
