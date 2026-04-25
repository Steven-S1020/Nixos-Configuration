{ inputs, ... }:
{
  den.aspects.programs._.nvf.homeManager =
    { pkgs, lib, ... }:
    let
      nvimPkg = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    in
    {
      # nvf provides its own HM module — import it here rather than globally
      imports = [ inputs.nvf.homeManagerModules.default ];

      home.packages = with pkgs; [
        texlive.combined.scheme-full
      ];

      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings.vim = {
          viAlias = true;
          vimAlias = true;
          enableLuaLoader = true;
          hideSearchHighlight = true;
          searchCase = "smart";

          treesitter = {
            enable = true;
            autotagHtml = true;
          };

          pluginOverrides.nvim-treesitter = nvimPkg;

          extraPlugins = with pkgs.vimPlugins; {
            vimtex = {
              package = vimtex;
              setup = /* lau */ ''
                vim.g.vimtex_view_method = "zathura"
                vim.g.vimtex_compiler_method = "latexmk"
                vim.g.vimtex_quickfix_mode = 2
              '';
            };
          };

          options = {
            mouse = "a";
            signcolumn = "no";
            scrolloff = 8;
            swapfile = false;
            softtabstop = 2;
            shiftwidth = 2;
            tabstop = 2;
            expandtab = true;
            smartindent = true;
            updatetime = 50;
            wrap = false;
          };

          clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers.wl-copy.enable = true;
          };

          lsp = {
            enable = true;
            formatOnSave = true;
            servers.nixd.settings.nil.nix.autoArchive = false;
          };

          languages = {
            enableFormat = true;
            enableExtraDiagnostics = true;
            bash.enable = true;
            clang.enable = true;
            css.enable = true;
            html.enable = true;
            java.enable = true;
            lua.enable = true;
            markdown.enable = true;
            python.enable = true;
            sql.enable = true;
            r.enable = true;
            nix = {
              enable = true;
              format.type = [ "nixfmt" ];
            };
            ts = {
              enable = true;
              lsp.servers = [ "ts_ls" ];
              format.type = [ "prettier" ];
              extraDiagnostics.types = [ "eslint_d" ];
            };
            julia.lsp = {
              enable = true;
              servers = pkgs.julia-bin;
            };
          };

          augroups = [ { name = "UserSetup"; } ];
          autocmds = [
            {
              event = [ "BufReadPost" ];
              pattern = [ "*" ];
              group = "UserSetup";
              desc = "remember last cursor place";
              callback = lib.generators.mkLuaInline ''
                function()
                  local mark = vim.api.nvim_buf_get_mark(0, '"')
                  local lcount = vim.api.nvim_buf_line_count(0)
                  if mark[1] > 0 and mark[1] <= lcount then
                    pcall(vim.api.nvim_win_set_cursor, 0, mark)
                  end
                end
              '';
            }
            {
              event = [ "FileType" ];
              pattern = [ "markdown" ];
              group = "UserSetup";
              desc = "Set spellcheck for Markdown";
              command = "setlocal spell";
            }
          ];

          # theme = {
          #   enable = true;
          #   name = "rose-pine";
          #   style = "main";
          # };

          ui = {
            noice.enable = true;
            borders = {
              enable = true;
              globalStyle = "rounded";
            };
            colorful-menu-nvim.enable = true;
            nvim-highlight-colors.enable = true;
            illuminate.enable = true;
          };

          autopairs.nvim-autopairs.enable = true;
          autocomplete.nvim-cmp.enable = true;
          telescope.enable = true;
          statusline.lualine.enable = true;

          notify.nvim-notify = {
            enable = true;
            setupOpts = {
              render = "minimal";
              stages = "static";
            };
          };

          terminal.toggleterm = {
            enable = true;
            setupOpts.direction = "float";
          };

          utility.preview.markdownPreview.enable = true;

          mini = {
            icons.enable = true;
            indentscope.enable = true;
            tabline = {
              enable = true;
              setupOpts.show_icons = true;
            };
          };

          filetree.nvimTree = {
            enable = true;
            openOnSetup = false;
            setupOpts = {
              sync_root_with_cwd = true;
              respect_buf_cwd = true;
              sort_by = "case_sensitive";
              git.enable = true;
              update_focused_file = {
                enable = true;
                update_root = true;
              };
              hijack_cursor = false;
              renderer = {
                group_empty = true;
                full_name = true;
                indent_markers.enable = true;
                icons = {
                  show = {
                    file = true;
                    folder = true;
                    folder_arrow = true;
                  };
                  glyphs = {
                    default = "󰈚";
                    symlink = "";
                    folder = {
                      default = "";
                      empty = "";
                      empty_open = "";
                      open = "";
                      symlink = "";
                      symlink_open = "";
                      arrow_open = "";
                      arrow_closed = "";
                    };
                    git = {
                      untracked = "";
                      staged = "";
                      deleted = "";
                      unstaged = "󰜀";
                      renamed = "";
                      ignored = "◌";
                      unmerged = "";
                    };
                  };
                };
              };
              filters.dotfiles = true;
              diagnostics = {
                enable = true;
                show_on_dirs = true;
              };
            };
          };
        };
      };
    };
}
