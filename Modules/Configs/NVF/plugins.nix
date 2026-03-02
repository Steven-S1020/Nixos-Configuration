{
  ...
}:

{
  programs.nvf = {
    settings = {
      vim = {
        autopairs.nvim-autopairs.enable = true;
        autocomplete.nvim-cmp.enable = true;
        telescope.enable = true;
        statusline.lualine.enable = true;
        git.gitsigns.enable = true;

        notify.nvim-notify = {
          enable = true;

          setupOpts = {
            render = "minimal";
            stages = "static";
          };
        };

        terminal.toggleterm = {
          enable = true;

          setupOpts = {
            direction = "float";
          };
        };

        utility = {
          preview.markdownPreview = {
            enable = true;
          };
        };

        mini = {
          icons.enable = true;
          indentscope.enable = true;
          tabline = {
            enable = true;

            setupOpts = {
              show_icons = true;
            };
          };
        };

        filetree = {
          nvimTree = {
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
                indent_markers = {
                  enable = true;
                };
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
              filters = {
                dotfiles = true;
              };
              diagnostics = {
                enable = true;
                show_on_dirs = true;
              };
            };
          };
        };
      };
    };
  };
}
