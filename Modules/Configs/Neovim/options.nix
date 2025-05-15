{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim = {

    # Packages just for neovim
    extraPackages = with pkgs; [
      # LSP
      clang-tools
      jdt-language-server
      nixd
      pyright
      sqls

      # Formatters
      python313Packages.autopep8
      nixfmt-rfc-style

      # Clipboard support
      xclip
      wl-clipboard
    ];

    # Home-Manager Options
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # ExtraLuaConfig: for general options that don't rely on plugins
    extraLuaConfig # lua
      = ''

        -- Test Comment
        -- Leader Key
        vim.g.mapleader = ' '

        -- Clipboard
        vim.opt.clipboard = 'unnamedplus'

        -- Enable Mouse
        vim.opt.mouse = 'a'

        -- Tabs
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.list = true

        -- Line Numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- Search Config
        vim.opt.incsearch = true
        vim.opt.hlsearch = false
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- Default Split Options
        vim.o.splitright = true
        vim.o.splitbelow = true

        -- Scrolling 
        vim.o.scrolloff = 8
        vim.o.sidescrolloff = 8

        -- Text Wrapping
        vim.o.wrap = false

        -- Transparent Background
        --vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
        --vim.cmd.highlight({ "NormalFloat", "guibg=NONE", "ctermbg=NONE" })
        --vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
        --vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

        -- Remember last place in buffer
        local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
        vim.api.nvim_clear_autocmds({ group = lastplace })
        vim.api.nvim_create_autocmd("BufReadPost", {
          group = lastplace,
          pattern = { "*" },
          desc = "remember last cursor place",
          callback = function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            local lcount = vim.api.nvim_buf_line_count(0)
            if mark[1] > 0 and mark[1] <= lcount then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end,
        })

        -- Set tabsize for *.nix
        vim.cmd([[
          augroup NixTabSettings
            autocmd!
            autocmd FileType nix setlocal tabstop=2 shiftwidth=2 expandtab
          augroup END
        ]])

        -- Keybind Function
        local function map(mode, lhs, rhs, opts)
          opts = opts or { noremap = true, silent = true }
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Keybinds Not Dependent On Plugins
        map('n', '<leader>v', ':vsplit<CR>')
        map('n', '<leader>s', ':split<CR>')
        map('n', '<C-h>', '<C-w>h')
        map('n', '<C-j>', '<C-w>j')
        map('n', '<C-k>', '<C-w>k')
        map('n', '<C-l>', '<C-w>l')
        map('v', '<C-s>', ':sort<CR>')
      '';

  };
}
