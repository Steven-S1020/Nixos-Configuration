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
      config # lua
        = ''
            vim.cmd.colorscheme('horizon')
            vim.o.background = "dark"

          -- Transparent background
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
        '';
    }
  ];
}
