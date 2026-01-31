{
  ...
}:

{

  home-manager.users.steven.programs.neovim.extraLuaConfig = /* lua */ ''
    ----[ Auto Commands ]----

    -- Alpha dashboard related behavior (hide/show tildes)
    local alpha_group = vim.api.nvim_create_augroup("AlphaDashboard", { clear = true })

    vim.api.nvim_create_autocmd({ "User", "BufEnter", "WinEnter" }, {
      group = alpha_group,
      callback = function(event)
        if (event.event == "User" and event.match == "AlphaReady") or vim.bo.filetype == "alpha" then
          vim.opt_local.fillchars:append({ eob = " " })
        end
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      group = alpha_group,
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "alpha" then
          vim.opt.fillchars:append({ eob = "~" })
        end
      end,
    })

    -- Highlight on Yank, cred: smnatale
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
      pattern = "*",
      desc = "highlight selection on yank",
      callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
      end,
    })

    -- LSP: format on save if supported
    local lsp_format_group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_format_group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_format_group,
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })

    --Python: autopep8 on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("Autopep8", { clear = true }),
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
