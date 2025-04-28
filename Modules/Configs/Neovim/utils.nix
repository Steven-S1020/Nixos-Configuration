{
  ...
}:

{

  home-manager.users.steven.programs.neovim.extraLuaConfig # lua
    =
      ''
        ----[ Custom Utils ]----

        ---- BetterInput: Floating Input Window
        ---- @param opts table Options controlling window size, style, prompt, etc.
        ---- @param on_submit function Callbacl function to call when the user submits input
        function BetterInput(opts, on_submit)
          local Input = require("nui.input")
          local event = require("nui.utils.autocmd").event

          local input = Input({
            position = "50%",
            size = {
              width = opts.width or 40,
            },
            border = {
              style = opts.border_style or "rounded",
              text = {
                top = opts.prompt or "Input",
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = opts.winhighlight or "Normal:Normal,FloatBorder:FloatBorder",
            },
          }, {
            prompt = opts.prompt_prefix or "> ",
            default_value = opts.default or "",
            on_submit = on_submit,
          })

          input:mount()

          input:map("n", "<Esc>", function()
            input:unmount()
            if opts.on_cancel then
              opts.on_cancel()
            end
          end)

          input:on(event.BufLeave, function()
            input:unmount()
          end)
        end

        ---- CreatePicker: Custom Telescope Picker
        ---- @param opts table Options for the picker (cmd, prompt_title, width, previewer, callback)
        CreatePicker = function(opts)
          local picker = require('telescope.pickers').new(
            require('telescope.themes').get_dropdown({
              prompt_title = opts.prompt_title or "Pick an option",
              width = opts.width or 0.5,
              previewer = opts.previewer or false,
            }),
            {
              finder = require('telescope.finders').new_oneshot_job(
                opts.cmd,
                {
                  entry_maker = function(entry)
                    return {
                      value = entry,
                      display = entry,
                      ordinal = entry,
                    }
                  end
                }
              ),
              sorter = require('telescope.config').values.generic_sorter({}),
              attach_mappings = function(prompt_bufnr)
                local actions = require('telescope.actions')
                local action_state = require('telescope.actions.state')

                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  if selection and opts.callback then
                    opts.callback(selection.value)
                  end
                end)
                return true
              end,
            }
          )

          picker:find()
        end

        ---- PickFileInDir: Custom File Picker
        ---- @param  dir string The directory path where Telescope search for files
        function PickFileInDir(dir)
          local telescope = require'telescope.builtin'
          telescope.find_files({
            cwd = dir,
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection ~= nil then
                  vim.cmd("edit " .. selection.path)
                  vim.cmd("cd " .. dir)
                end
              end)

              return true
            end,
          })
        end
      '';
}
