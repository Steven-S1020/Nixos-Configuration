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
        texlab

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;

      ### General config ###
      extraLuaConfig = /*lua*/ ''
        -- Clipboard
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.mouse = 'a'

        -- Tabs
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.list = true

        -- Line numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- Search config
        vim.opt.incsearch = true
        vim.opt.hlsearch = false
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

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
      '';

      ### plugins ###
      plugins =
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
      in
      with pkgs.vimPlugins; [
        {
          plugin = monokai-pro-nvim;
          config = "colorscheme monokai-pro";
        }
        {
          plugin = indent-blankline-nvim;
          config = toLua /*lua*/ ''
            require("ibl").setup {
              scope = { enabled = false }
            }
          '';
        }
        {
          plugin = neo-tree-nvim;
          config = toLua /*lua*/ ''
            vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
            vim.cmd('cnoreabbrev nt NT')

            -- close if last open
            require("neo-tree").setup({
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
          config = toLua /*lua*/ ''
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
          plugin = nvim-lspconfig;
          config = toLua /*lua*/ ''
            require'lspconfig'.clangd.setup{}
            require'lspconfig'.jdtls.setup{}
            require'lspconfig'.nixd.setup{}
            require'lspconfig'.pyright.setup{}
            require'lspconfig'.rust_analyzer.setup{}
            require'lspconfig'.texlab.setup{
              settings = {
                texlab = {
                  build = {
                    executable = "latexmk",
                    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                    onSave = true,
                  },
                  forwardSearch = {
                    executable = "brave",
                    args = { "--new-tab", "%p" },
                  },
                  chktex = {
                    onOpenAndSave = true,
                    onEdit = false,
                  },
                }
              }
            }
          '';
        }
        {
          plugin = telescope-nvim;
          config = toLua /*lua*/ ''
            -- Rebind commands
            vim.api.nvim_create_user_command('FF', 'Telescope find_files', {})
            vim.cmd('cnoreabbrev ff FF')
            vim.api.nvim_create_user_command('FG', 'Telescope live_grep', {})
            vim.cmd('cnoreabbrev fg FG')

            -- Run on launch
            vim.api.nvim_create_autocmd("VimEnter", {
              callback = function()
                if vim.fn.argv(0) == "" then
                  require("telescope.builtin").find_files()
                  end
              end
            })
          '';
        }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-bash
            p.tree-sitter-cpp
            p.tree-sitter-java
            p.tree-sitter-json
            p.tree-sitter-latex
            p.tree-sitter-lua
            p.tree-sitter-nix
            p.tree-sitter-python
            p.tree-sitter-rust
            p.tree-sitter-vim
          ]));
          config = toLua /*lua*/ ''
            require('nvim-treesitter.configs').setup {
              ensure_installed = {},
              auto_install = false,
              highlight = { enable = true },
            }
          '';
        }
        {
          plugin = ultisnips;
          config = ''
            let g:UltiSnipsSnippetDirectories=['/etc/nixos/Modules/Configs/Snippets/']
            let g:UltiSnipsExpandTrigger = '<tab>'
            let g:UltiSnipsJumpForwardTrigger = '<tab>'
            let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
          '';
        }
        {
          plugin = vim-visual-increment;
          config = ''
            set nrformats=alpha,octal,hex
          '';
        }
      ];

    };
  };

}
