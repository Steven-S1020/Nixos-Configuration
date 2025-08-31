{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = alpha-nvim;
      type = "lua";
      config # lua
        = ''
          local alpha = require'alpha'
          local dashboard = require'alpha.themes.dashboard'
          local telescope = require'telescope.builtin'
          local pickers = require'telescope.pickers'
          local finders = require'telescope.finders'
          local actions = require'telescope.actions'
          local themes = require'telescope.themes'
          local action_state = require'telescope.actions.state'
          local conf = require('telescope.config').values

          ---- Main Menu
          function Main_Menu()
            dashboard.section.buttons.val = {
              dashboard.button('n', ' Nix Telescope', function()
                local path = '/etc/nixos'
                vim.fn.chdir(path)
                require'telescope.builtin'.find_files({ cwd = path })
                end),
              dashboard.button('N', ' Nix Cli', function()
                vim.fn.chdir('/etc/nixos')
                vim.cmd('TermNew')
              end),
              dashboard.button('f', '󰱼 Find Files', function() telescope.find_files() end),
              dashboard.button('r', '󱎸 Ripgrep', function() telescope.live_grep() end),
              dashboard.button('c', ' CLI', function() vim.cmd('qa') end),
            }
            vim.cmd('AlphaRemap')
            vim.cmd('AlphaRedraw')
          end

          ---- Header
          --local logo = dotfile('/etc/nixos/Assets/ASCII-Art/logo.lua')
          --dashboard.sections.header = logo
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
  ];
}
