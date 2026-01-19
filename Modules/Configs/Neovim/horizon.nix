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
  };
in
{
  home-manager.users.steven.programs.neovim.plugins = [
    {
      plugin = horizon;
      type = "lua";
      config = /* lua */ ''
        require'horizon'.setup{
          overrides = {
            colors = {
              CursorLine = { bg = "#1e1e1e", fg = "#ffffff", underline = true },
              LineNr = { fg = "#d5d8da", bg = "none" },
              CursorLineNr = { fg = "#f1f2f3", bold = true, bg = "none" },
              Normal = { bg = "none" },
              NormalFloat = { bg = "none" },
              NonText = { bg = "none" },
            }
          }
        }
        ---[ Set Theme & Overrides ]---
        vim.o.background = "dark"
        vim.cmd.colorscheme'horizon'

        vim.api.nvim_set_hl(0, "LineNr", { fg = "#d5d8da", bg = "none" })
        vim.api.nvim_set_hl(0, "ToggleTerm1Normal", { bg = "none" })
      '';
    }
  ];
}
