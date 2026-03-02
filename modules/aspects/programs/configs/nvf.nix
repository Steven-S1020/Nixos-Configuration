{ inputs, ... }:
{
  den.aspects.programs._.nvf.homeManager =
    { pkgs, ... }:
    {
      # nvf provides its own HM module — import it here rather than globally
      imports = [ inputs.nvf.homeManagerModules.default ];

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
            context.enable = true;
            autotagHtml = true;
          };

          pluginOverrides.nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;

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
          };

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            providers.xclip.enable = true;
          };

          spellcheck = {
            enable = true;
            languages = [ "en" ];
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

          theme = {
            enable = true;
            name = "oxocarbon";
            style = "dark";
          };

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
                    symlink = "";
                    folder = {
                      default = "";
                      empty = "";
                      empty_open = "";
                      open = "";
                      symlink = "";
                      symlink_open = "";
                      arrow_open = "";
                      arrow_closed = "";
                    };
                    git = {
                      untracked = "";
                      staged = "";
                      deleted = "";
                      unstaged = "󰜀";
                      renamed = "";
                      ignored = "◌";
                      unmerged = "";
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
