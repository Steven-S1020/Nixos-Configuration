''
  
  -- Clipboard Stuff
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.mouse = 'a'

  -- Tabs
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true

  -- Line Numbers 
  vim.opt.number = true
  vim.opt.relativenumber = true

  -- Search Config
  vim.opt.incsearch = true
  vim.opt.hlsearch = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Neotree Config
  require("neo-tree").setup({
    close_if_last_window = true,
  })

  -- Launch Config
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.cmd("Neotree")
      vim.cmd("wincmd p")
      if vim.fn.argv(0) == "" then
        require("telescope.builtin").find_files()
        end
    end  
  })
  
  -- Java Slight Syntax Highlighting
  vim.cmd[[
    let java_highlight_function = 1
    let java_highlight_all = 1
    set filetype=java
    highlight link javaScopeDecl Statement
    highlight link javaType Type
    highlight link javaDocTags PreProc
  ]]

  -- Python Treesitter Settings
  require'nvim-treesitter.configs'.setup {
    parser_install_dir = '/etc/nixos/Modules/Configs/Neovim/Parsers',
    ensure_installed = none,
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  }
  vim.opt.runtimepath:append('/etc/nixos/Modules/Configs/Neovim/Parsers')

  -- Python Formatting
  vim.cmd [[
    autocmd BufWritePre *.py execute ':!black %'
  ]]
''
