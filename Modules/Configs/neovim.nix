{ pkgs, ... }:

{

  home-manager.users.steven = {
    programs.neovim = {

      extraPackages = with pkgs; [
        # LSP
        clang-tools
        jdt-language-server
        nixd
        pyright
        rust-analyzer

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      ### General config ###
      extraLuaConfig /*lua*/ =
        ''

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
          vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
          vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })

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

      ### plugins ###
      plugins =
        with pkgs.vimPlugins;
        [
          {
            plugin = telescope-nvim;
            type = "lua";
            config /*lua*/ =
              ''
                map('n', '<leader>f', require'telescope.builtin'.find_files)
                map('n', '<leader>g', require'telescope.builtin'.live_grep)
              '';
          }
          {
            plugin = alpha-nvim;
            type = "lua";
            config /*lua*/ =
              ''
                --
                local alpha = require'alpha'
                local dashboard = require'alpha.themes.dashboard'
                local telescope = require'telescope.builtin'

                function find_files_in_dir(dir)
                  telescope.find_files({ cwd = dir })
                end

                function show_main_menu()
                  dashboard.section.buttons.val = {
                    dashboard.button('p', 'Project', show_project_menu),
                    dashboard.button('n',' Nix Config', function() find_files_in_dir("/etc/nixos") end),
                    dashboard.button('f','󰍉 Find Files', function() telescope.find_files() end),
                    dashboard.button('c',' CLI', function() vim.cmd('qa') end),
                  }
                  alpha.setup(dashboard.config)
                  vim.cmd('AlphaRedraw')
                end

                function show_project_menu()
                  dashboard.section.buttons.val = {
                    dashboard.button('o', 'Open Existing Project', function()
                      telescope.find_files({
                        cwd = '~/Code',  -- Set to your directory
                        prompt_title = "Select Project Directory",
                        find_command = { "fd", "--type", "d", "--exact-depth", "2"},  -- Custom find command for directory depth
                      })
                    end),
                    dashboard.button('<BS>', 'Back', show_main_menu),
                  }
                  alpha.setup(dashboard.config)
                  vim.cmd('AlphaRemap')
                  vim.cmd('AlphaRedraw')
                end


                dashboard.section.header.val = {
                  [[ __  __               _____   ____       ]],
                  [[/\ \/\ \  __         /\  __`\/\  _`\     ]],
                  [[\ \ `\\ \/\_\   __  _\ \ \/\ \ \,\L\_\   ]],
                  [[ \ \ , ` \/\ \ /\ \/'\\ \ \ \ \/_\__ \   ]],
                  [[  \ \ \`\ \ \ \\/>  </ \ \ \_\ \/\ \L\ \ ]],
                  [[   \ \_\ \_\ \_\/\_/\_\ \ \_____\ `\____\]],
                  [[    \/_/\/_/\/_/\//\/_/  \/_____/\/_____/]],
                }

                dashboard.config.layout = {
                  { type = 'padding', val = 10 },
                  dashboard.section.header,
                  { type = 'padding', val = 3 },
                  dashboard.section.buttons,
                }

                dashboard.section.header.opts.hl = 'Include'
                dashboard.section.buttons.opts.hl = 'Keyword'

                alpha.setup(dashboard.opts)
                show_main_menu()
              '';
          }
          {
            plugin = monokai-pro-nvim;
            config = "colorscheme monokai-pro";
          }
          {
            plugin = indent-blankline-nvim;
            type = "lua";
            config /*lua*/ =
              ''
                require'ibl'.setup {
                  scope = { enabled = false }
                }
              '';
          }
          {
            plugin = neo-tree-nvim;
            type = "lua";
            config /*lua*/ =
              ''
                vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
                vim.cmd('cnoreabbrev nt NT')

                -- close if last open
                require'neo-tree'.setup({
                  close_if_last_window = true,
                })
              '';
          }
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp-nvim-ultisnips
          {
            plugin = nvim-cmp;
            type = "lua";
            config /*lua*/ =
              ''
                local cmp = require'cmp'

                cmp.setup({
                  snippet = {
                    expand = function(args)
                      vim.fn["UltiSnips#Anon"](args.body)
                    end,
                  },
                  mapping = cmp.mapping.preset.insert ({
                     ['<C-n>'] = cmp.mapping.select_next_item(),
                     ['<C-p>'] = cmp.mapping.select_prev_item(),
                     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                  }),
                  sources = cmp.config.sources ({
                    { name = 'nvim_lsp'},
                    { name = 'buffer'},
                    { name = 'path'},
                    { name = 'ultisnips'},
                  })
                })
              '';
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config /*lua*/ =
              ''
                require'lualine'.setup {
                  sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'filetype' },
                    lualine_y = { 'lsp_status' },
                    lualine_z = { 'selectioncount', 'location' }
                  }
                }
              '';
          }
          nvim-web-devicons
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config /*lua*/ =
              ''
                require'lspconfig'.clangd.setup{}
                require'lspconfig'.jdtls.setup{}
                require'lspconfig'.nixd.setup{}
                require'lspconfig'.pyright.setup{}
                require'lspconfig'.rust_analyzer.setup{}

                map('n', '<leader>d', function()
                  vim.diagnostics.open_float(nil, { focusable = false })
                end)
              '';
          }
          {
            plugin = (
              nvim-treesitter.withPlugins (p: [
                p.tree-sitter-bash
                p.tree-sitter-cpp
                p.tree-sitter-java
                p.tree-sitter-json
                p.tree-sitter-latex
                p.tree-sitter-lua
                p.tree-sitter-nix
                p.tree-sitter-python
                p.tree-sitter-rust
                p.tree-sitter-sql
                p.tree-sitter-vim
              ])
            );
            type = "lua";
            config /*lua*/ =
              ''
                require('nvim-treesitter.configs').setup {
                  ensure_installed = {},
                  auto_install = false,
                  highlight = { enable = true },
                }
              '';
          }
          {
            plugin = ultisnips;
            type = "lua";
            config /*lua*/ =
            ''
              vim.g.UltiSnipsSnippetDirectories={'/etc/nixos/Modules/Configs/Snippets/'}
              vim.g.UltiSnipsExpandTrigger = '<tab>'
              vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
              vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
            '';
          }
          {
            plugin = vim-visual-increment;
            type = "lua";
            config /*lua*/ =
            ''
              vim.cmd('set nrformats=alpha,octal,hex')
            '';
          }
        ];
    };
  };
}
