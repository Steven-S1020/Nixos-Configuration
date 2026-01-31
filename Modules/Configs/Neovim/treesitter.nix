{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = /* lua */ ''
        -- Ensure JSX/TSX files use the correct treesitter parsers
        vim.treesitter.language.register("javascript", "javascriptreact")
        vim.treesitter.language.register("typescript", "typescriptreact")


        vim.api.nvim_create_autocmd("FileType", {
          pattern = "*",
            callback = function(event)
              local bufnr = event.buf
              local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)

              if not lang then
                  return -- no parser for this filetype
              end

              local ok = pcall(vim.treesitter.get_parser, bufnr, lang)

              if ok then
                  vim.treesitter.start(bufnr, lang)
              end
            end,
        })
      '';
    }
  ];
}
