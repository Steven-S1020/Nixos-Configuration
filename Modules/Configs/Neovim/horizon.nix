{
  pkgs,
  ...
}:

let
  horizon = pkgs.vimUtils.buildVimPlugin {
    name = "horizon-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "horizon.nvim";
      rev = "b4d7b1e7c3aa77aea31b9ced8960e49fd8682c47";
      hash = "sha256-X4ZUtLp7KvX5h9qTfvlCHHYAn7xdnw4DZXebf240DoI=";
    };
    # patchPhase = ''
    #     echo "▶ Patching Horizon theme..."

    #     # 1. Inject config.lua to store user setup
    #     mkdir -p lua/horizon
    #     cat > lua/horizon/config.lua <<EOF
    #   local M = {}
    #   M.options = {
    #     plugins = {},
    #     overrides = {},
    #   }
    #   function M.setup(opts)
    #     M.options = vim.tbl_deep_extend("force", M.options, opts or {})
    #   end
    #   function M.get()
    #     return M.options
    #   end
    #   return M
    #   EOF

    #     # 2. Replace colors/horizon.lua to forward to setup()
    #     cat > colors/horizon.lua <<EOF
    #   -- Only call setup() if it hasn't already been run
    #   if not package.loaded["horizon.config"] then
    #     require("horizon").setup()
    #   end
    #   EOF

    #     # 3. Inject debug print into theme.lua
    #     sed -i '/function M.set_highlights(config)/a print("HORIZON CONFIG:", vim.inspect(config))' lua/horizon/theme.lua

    #     # 4. Inject override application block *inside* set_highlights()
    #     sed -i '/function M.set_highlights(config)/a \
    #   -- Apply user highlight overrides\
    #   \nfor group, opts in pairs(config.overrides or {}) do\
    #   \n  vim.api.nvim_set_hl(0, group, opts)\
    #   \nend' lua/horizon/theme.lua

    #   mkdir -p lua/horizon/theme
    #   cp lua/horizon/theme.lua lua/horizon/theme/init.lua
    # '';
  };
in
{
  home-manager.users.steven.programs.neovim.plugins = [
    {
      plugin = horizon;
      type = "lua";
      config # lua
        = ''
          require("horizon").setup({
            plugins = {
              cmp = true,
              telescope = true,
              indent_blankline = true,
              neo_tree = true,
            },
            overrides = {
              CursorLine = { bg = "#1e1e1e", fg = "#ffffff", underline = true },
              LineNr = { fg = "#d5d8da", bg = "none" },
              CursorLineNr = { fg = "#f1f2f3", bold = true, bg = "none" },
              Normal = { bg = "none" },
              NormalFloat = { bg = "none" },
              NonText = { bg = "none" },
            },
          })

          vim.o.background = "dark"
        '';
    }
  ];
}
