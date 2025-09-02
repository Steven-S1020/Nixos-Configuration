{
  pkgs,
  ...
}:

let
  xeno = pkgs.vimUtils.buildVimPlugin {
    name = "xeno.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "kyza0d";
      repo = "xeno.nvim";
      rev = "4a1d3946b5c3b9b581e76a84746a06b0977b1fed";
      hash = "sha256-zdFT/8CkRdAjXoUYEIX/8fMMyVHs18aJf/+Fv4MYctE=";
    };
  };
in
{
  home-manager.users.steven.programs.neovim.plugins = [
    {
      plugin = xeno;
      type = "lua";
      config # lua
        = ''
          require('xeno').new_theme('red-theme', {
            base = '#272c33',
            accent = '#ac4242',
            contrast = -0.3,
            variation = 0.7,

            -- NvimLightGreen:#B3F6C0
            -- YellowWarning:#E7C547
            -- Purple:#776885
            -- LightPurple:#A997DF
            -- Sunset:#F9C784
            -- DarkGreen:#3f612D
            -- LightGreen:#8DB580

            -- Normal: fg:#A0B0C5 bg:#0D1013

            highlights = {
              editor = {
                FloatBorder = { bg = '#0D1013' },
              },

              syntax = {
                Boolean = { fg = '#A997DF' },
                ['@boolean'] = { fg = '#A997DF' },
                Function = { fg = '#B3F6C0' },
                ['@function'] = { fg = '#B3F6C0' },
                Type = { fg = '#F9C784' },
                ['@type'] = { fg = '#F9C784' },
                Float = { fg = '#EE5858' },
                ['@float'] = { fg = '#EE5858' },
              },
              plugins = {
                ['nvim-telescope/telescope.nvim'] = {
                  TelescopeNormal = { bg = '#0D1013' },
                  TelescopePromptNormal = { bg = '#0D1013' },
                  TelescopeSelection = { bg = '@base.700' },
                  TelescopeSelectionCaret = { bg = '@base.700' },
                },
              },
            },
          })

          vim.cmd('colorscheme red-theme')
        '';
    }
  ];
}
