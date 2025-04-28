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
              dashboard.button('p', '󰈮 Project', Project_Menu),
              dashboard.button('n', ' Nix Config', function() PickFileInDir("/etc/nixos") end),
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
  ];
}
