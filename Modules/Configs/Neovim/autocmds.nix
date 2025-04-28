{
  ...
}:

{

  home-manager.users.steven.programs.neovim.extraLuaConfig # lua
    =
      ''
        ----[ Auto Commands ]----

        ---- Autocmd: Manage tildes in Alpha dashboard
        vim.api.nvim_create_autocmd({ "User", "BufEnter", "WinEnter" }, {
          callback = function(event)
            if (event.event == "User" and event.match == "AlphaReady") or vim.bo.filetype == "alpha" then
              -- When Alpha is ready or we re-enter Alpha, hide ~ tildes
              vim.opt_local.fillchars:append({ eob = " " })
            end
          end,
        })

        vim.api.nvim_create_autocmd("BufUnload", {
          pattern = "*",
          callback = function()
            if vim.bo.filetype == "alpha" then
              -- When Alpha buffer actually unloads (quitting dashboard), restore ~ tildes
              vim.opt.fillchars:append({ eob = "~" })
            end
          end,
        })

        ---- Autocmd: Auto-Format on save if LSP supports it
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            -- Format on save if supported
            if client.supports_method('textDocument/formatting') then
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
              })
            end
          end,
        })

        ---- Autocmd: Auto-Run autopep8 after saving *.py
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = "*.py",
          callback = function()
            local filepath = vim.api.nvim_buf_get_name(0)
            vim.fn.jobstart({ "autopep8", "--in-place", filepath }, {
              on_exit = function()
                vim.schedule(function()
                  vim.cmd("edit!") -- reload the buffer after formatting
                end)
              end,
            })
          end,
        })
      '';
}
