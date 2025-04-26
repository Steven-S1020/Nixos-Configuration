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
        sqls

        # Formatters
        python313Packages.autopep8
        nixfmt-rfc-style

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      ### General config ###
      extraLuaConfig # lua
        = ''

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

          -- Autocmd to manage ~ tildes in Alpha dashboard
          vim.api.nvim_create_autocmd({ "User", "BufEnter", "WinEnter" }, {
            callback = function(event)
              if (event.event == "User" and event.match == "AlphaReady") or vim.bo.filetype == "alpha" then
                -- When Alpha is ready or we re-enter Alpha, hide ~ tildes
                vim.opt_local.fillchars:append({ eob = " " })
              end
            end,
          })

          vim.api.nvim_create_autocmd("BufUnload", {
            pattern = "*",
            callback = function()
              if vim.bo.filetype == "alpha" then
                -- When Alpha buffer actually unloads (quitting dashboard), restore ~ tildes
                vim.opt.fillchars:append({ eob = "~" })
              end
            end,
          })

          -- BetterInput function using nui.nvim
          local Input = require("nui.input")
          local event = require("nui.utils.autocmd").event

          function BetterInput(opts, on_submit)
            local input = Input({
              position = "50%",
              size = {
                width = opts.width or 40,
              },
              border = {
                style = opts.border_style or "rounded",
                text = {
                  top = opts.prompt or "Input",
                  top_align = "center",
                },
              },
              win_options = {
                winhighlight = opts.winhighlight or "Normal:Normal,FloatBorder:FloatBorder",
              },
            }, {
              prompt = opts.prompt_prefix or "> ",
              default_value = opts.default or "",
              on_submit = on_submit,
            })

            input:mount()

            input:map("n", "<Esc>", function()
              input:unmount()
              if opts.on_cancel then
                opts.on_cancel()
              end
            end)

            input:on(event.BufLeave, function()
              input:unmount()
            end)
          end
        '';

      ### plugins ###
      plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          type = "lua";
          config # lua
            = ''
              map('n', '<leader>f', require'telescope.builtin'.find_files)
              map('n', '<leader>g', require'telescope.builtin'.live_grep)
              vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
              vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
            '';
        }
        {
          plugin = alpha-nvim;
          type = "lua";
          config # lua
            = ''
              -----
              local alpha = require'alpha'
              local dashboard = require'alpha.themes.dashboard'
              local telescope = require'telescope.builtin'
              local pickers = require'telescope.pickers'
              local finders = require'telescope.finders'
              local actions = require'telescope.actions'
              local themes = require'telescope.themes'
              local action_state = require'telescope.actions.state'
              local conf = require('telescope.config').values

              ----  Utility: open file picker in a specific directory
              function find_files_in_dir(dir)
                telescope.find_files({
                  cwd = dir,
                  attach_mappings = function(prompt_bufnr, map)
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    actions.select_default:replace(function()
                      actions.close(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      if selection ~= nil then
                        vim.cmd("edit " .. selection.path)
                        vim.cmd("cd " .. dir)
                      end
                    end)

                    return true
                  end,
                })
              end

              ---- Utility: create a general picker
              CreatePicker = function(opts)
                local picker = require('telescope.pickers').new(
                  require('telescope.themes').get_dropdown({
                    prompt_title = opts.prompt_title or "Pick an option",
                    width = opts.width or 0.5,
                    previewer = opts.previewer or false,
                  }),
                  {
                    finder = require('telescope.finders').new_oneshot_job(
                      opts.cmd,
                      {
                        entry_maker = function(entry)
                          return {
                            value = entry,
                            display = entry,
                            ordinal = entry,
                          }
                        end
                      }
                    ),
                    sorter = require('telescope.config').values.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr)
                      local actions = require('telescope.actions')
                      local action_state = require('telescope.actions.state')

                      actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        if selection and opts.callback then
                          opts.callback(selection.value)
                        end
                      end)
                      return true
                    end,
                  }
                )

                picker:find()
              end

              ---- Main Menu
              function Main_Menu()
                dashboard.section.buttons.val = {
                  dashboard.button('p', '󰈮 Project', Project_Menu),
                  dashboard.button('n', ' Nix Config', function() find_files_in_dir("/etc/nixos") end),
                  dashboard.button('f', '󰱼 Find Files', function() telescope.find_files() end),
                  dashboard.button('r', '󱎸 Ripgrep', function() telescope.live_grep() end),
                  dashboard.button('c', ' CLI', function() vim.cmd('qa') end),
                }
                vim.cmd('AlphaRemap')
                vim.cmd('AlphaRedraw')
              end

              ---- Project Menu
              function Project_Menu()
                dashboard.section.buttons.val = {
                  dashboard.button('o', ' Open Existing Project', function()
                    telescope.find_files({
                      cwd = '~/Code',  -- Set to your directory
                      prompt_title = "Select Project Directory",
                      find_command = { "fd", "--type", "d", "--exact-depth", "2"},  ---- Custom find command for directory depth
                    })
                  end),
                  dashboard.button('n', ' New Project', Create_Project_Menu),
                  dashboard.button('<BS>', '󰭜 Back', Main_Menu),
                }
                vim.cmd('AlphaRemap')
                vim.cmd('AlphaRedraw')
              end

              ---- Create Project Menu
              function Create_Project_Menu()
                dashboard.section.buttons.val = {
                  dashboard.button('g', '󰲋 General Project', function()
                    BetterInput({ prompt = "[ Project Name ]" }, function(name)
                      if not name or name == "" then return end
                      CreatePicker({
                        prompt_title = "Mkdev Recipes",
                        cmd = { 'bash', '-c', "mk list -t plain" },
                        callback = function(recipe)
                          if not recipe or recipe == "" then return end
                          local full_path = string.format("%s/%s", vim.fn.expand("~/Code/Projects"), name)
                          vim.fn.mkdir(full_path, "p")
                          local job_id = vim.fn.jobstart(string.format("cd '%s' && mk evoke %s", full_path, recipe))
                          vim.fn.jobwait({job_id})
                          require("telescope.builtin").find_files({ cwd = full_path })
                        end,
                      })
                    end)
                  end),

                  dashboard.button('c', ' Class Project', function()
                    CreatePicker({
                      prompt_title = "[ Class Folder ]",
                      cmd = { 'bash', '-c', 'ls ~/Code/School' },
                      callback = function(class)
                        if not class or class == "" then return end
                        BetterInput({ prompt = "[ Project Name ]" }, function(name)
                          if not name or name == "" then return end
                          CreatePicker({
                            prompt_title = "Mkdev Recipes",
                            cmd = { 'bash', '-c', "mk list -t plain" },
                            callback = function(recipe)
                              if not recipe or recipe == "" then return end
                              local full_path = string.format("%s/%s", vim.fn.expand("~/Code/Projects"), name)
                              vim.fn.mkdir(full_path, "p")
                              local job_id = vim.fn.jobstart(string.format("cd '%s' && mk evoke %s", full_path, recipe))
                              vim.fn.jobwait({job_id})
                              require("telescope.builtin").find_files({ cwd = full_path })
                            end,
                          })
                        end)
                      end,
                    })
                  end),

                  dashboard.button('d', ' New Class Dir', function()
                    BetterInput({ prompt = "[ Class Name ]" }, function(class_name)
                      if not class_name or class_name == "" then return end
                      local path = string.format("%s/%s", vim.fn.expand("~/Code/School"), class_name)
                      vim.fn.mkdir(path, "p")
                      vim.notify("Created Class Folder: " .. path, vim.log.levels.INFO)
                    end)
                  end),

                  dashboard.button('<BS>', '󰭜 Back', Project_Menu),
                }
                vim.cmd('AlphaRemap')
                vim.cmd('AlphaRedraw')
              end

              ---- Header
              dashboard.section.header.val = {
                [[ __  __               _____   ____       ]],
                [[/\ \/\ \  __         /\  __`\/\  _`\     ]],
                [[\ \ `\\ \/\_\   __  _\ \ \/\ \ \,\L\_\   ]],
                [[ \ \ , ` \/\ \ /\ \/'\\ \ \ \ \/_\__ \   ]],
                [[  \ \ \`\ \ \ \\/>  </ \ \ \_\ \/\ \L\ \ ]],
                [[   \ \_\ \_\ \_\/\_/\_\ \ \_____\ `\____\]],
                [[    \/_/\/_/\/_/\//\/_/  \/_____/\/_____/]],
              }

              ---- Layout and Highlights
              dashboard.section.header.opts.hl = 'Include'
              dashboard.section.buttons.opts.hl = 'Keyword'

              dashboard.config.layout = {
                { type = 'padding', val = 10 },
                dashboard.section.header,
                { type = 'padding', val = 3 },
                dashboard.section.buttons,
              }

              ---- Setup Alpha
              alpha.setup(dashboard.opts)

              ---- Launch Main Menu
              Main_Menu()
            '';
        }
        {
          plugin = barbar-nvim;
          type = "lua";
          config = # lua
            ''
              --> barbar-nvim <--
              map('n', '<S-Tab>', ':BufferNext<CR>')
              map('n', '<S-w>', ':BufferClose<CR>')
            '';
        }
        {
          plugin = monokai-pro-nvim;
          type = "lua";
          config # lua
            = ''
              require('monokai-pro').setup({
                transparent_background = true,
                background_clear = {
                  "float_win",
                  "telescope",
                  "TelescopeNormal",
                  "TelescopeBorder",
                  "TelescopePromptNormal",
                  "TelescopePromptBorder",
                  "TelescopeResultsNormal",
                  "TelescopeResultsBorder",
                  "TelescopePreviewNormal",
                  "TelescopePreviewBorder",
                },
              })

              vim.cmd('colorscheme monokai-pro')
            '';
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config # lua
            = ''
              require'ibl'.setup {
                scope = { enabled = false }
              }
            '';
        }
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config # lua
            = ''
              vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
              vim.cmd('cnoreabbrev nt NT')

              -- close if last open
              require'neo-tree'.setup({
                close_if_last_window = true,
              })
            '';
        }
        nui-nvim
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-nvim-ultisnips
        {
          plugin = nvim-cmp;
          type = "lua";
          config # lua
            = ''
              local cmp = require'cmp'

              cmp.setup({
                window = {
                  border = 'rounded',
                },
                completion = {
                  border = 'rounded',
                },
                snippet = {
                  expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                  end,
                },
                mapping = cmp.mapping.preset.insert ({
                   ['<Tab>'] = cmp.mapping.select_next_item(),
                   ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
          config # lua
            = ''
              require'lualine'.setup {
                options = {
                  theme = 'monokai-pro'
                },
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
          config # lua
            = ''
              ---- lsp config
              vim.lsp.enable('clangd')
              vim.lsp.enable('jdtls')
              vim.lsp.enable('nixd')
              vim.lsp.config('nixd', {
                  settings = {
                      formatting = {
                          command = { "nixfmt" },
                      },
                  }
              })
              vim.lsp.enable('pyright')
              vim.lsp.enable('sqls')

              -- Keybind for diagnostic window
              map('n', '<leader>d', function()
                  vim.diagnostic.open_float(nil, { focusable = false })
              end)

              -- Autocommands
              vim.api.nvim_create_autocmd('LspAttach', {
                  callback = function(args)
                      local client = vim.lsp.get_client_by_id(args.data.client_id)
                      -- Format on save if supported
                      if client.supports_method('textDocument/formatting') then
                          vim.api.nvim_create_autocmd('BufWritePre', {
                              buffer = args.buf,
                              callback = function()
                                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                              end,
                          })
                      end
                  end,
              })

              vim.api.nvim_create_autocmd("BufWritePost", {
                  pattern = "*.py",
                  callback = function()
                      local filepath = vim.api.nvim_buf_get_name(0)
                      vim.fn.jobstart({ "autopep8", "--in-place", filepath }, {
                          on_exit = function()
                              vim.schedule(function()
                                  vim.cmd("edit!") -- reload the buffer after formatting
                              end)
                          end,
                      })
                  end,
              })
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
          config # lua
            = ''
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
          config # lua
            = ''
              vim.g.UltiSnipsSnippetDirectories={'/etc/nixos/Modules/Configs/Snippets/'}
              vim.g.UltiSnipsExpandTrigger = '<tab>'
              vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
              vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
            '';
        }
        {
          plugin = vim-visual-increment;
          type = "lua";
          config # lua
            = ''
              vim.cmd('set nrformats=alpha,octal,hex')
            '';
        }
      ];
    };
  };
}
