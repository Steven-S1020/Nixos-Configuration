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

          ---- Project Menu
          function Project_Menu()
            dashboard.section.buttons.val = {
              dashboard.button('o', ' Open Telescope', PickProjectWithTelescope), --function()
              dashboard.button("O", " Open Cli", function()
                pickers.new(themes.get_dropdown({
                  prompt_title = "Select a Project",
                }), {
                  finder = finders.new_oneshot_job(
                    { "fd", "--type", "d", "--exact-depth", "2", "." },
                    { cwd = vim.fn.expand("~/Code") }
                  ),
                  sorter = conf.generic_sorter({}),
                  attach_mappings = function(prompt_bufnr)
                    actions.select_default:replace(function()
                      actions.close(prompt_bufnr)

                      local selection = action_state.get_selected_entry()
                      if selection and selection.value then
                        local full_path = vim.fn.expand("~/Code/" .. selection.value)

                        vim.cmd("cd " .. vim.fn.fnameescape(full_path))
                        vim.cmd("TermNew")
                      end
                    end)
                    return true
                  end,
                }):find()
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
