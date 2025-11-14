{
  pkgs,
  config,
  ...
}:

let
  c = config.colors;

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
            base = '#${c.base.hex}',
            accent = '#${c.red.hex}',
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
                FloatBorder = { bg = '#${c.black.hex}' },
                PmenuSel = { bg = '@base.600' },
              },

              syntax = {
                Boolean = { fg = '#${c.purple.hex}' },
                ['@boolean'] = { fg = '#${c.purple.hex}'},
                Function = { fg = '#${c.lightgreen.hex}' },
                ['@function'] = { fg = '#${c.lightgreen.hex}' },
                Type = { fg = '#${c.yellow.hex}' },
                ['@type'] = { fg = '#${c.yellow.hex}' },
                Float = { fg = '#${c.darkred.hex}' },
                ['@float'] = { fg = '#${c.darkred.hex}' },
              },
              plugins = {
                ['nvim-telescope/telescope.nvim'] = {
                  TelescopeNormal = { bg = '#${c.black.hex}' },
                  TelescopePromptNormal = { bg = '#${c.black.hex}' },
                  TelescopeSelectionCaret = { fg = '@base.200', bg = '@base.600' },
                },
              },
            },
          })

          vim.cmd('colorscheme red-theme')
        '';
    }
  ];
}
