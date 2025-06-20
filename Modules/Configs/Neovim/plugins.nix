{
  pkgs,
  ...
}:

{

  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    # Basic Utilities
    nui-nvim
    nvim-web-devicons

    # Visuals
    indent-blankline-nvim

    # LSP Support
    nvim-lspconfig

    vimtex

    # Completion Engine
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-nvim-ultisnips

    # Snippets
    ultisnips

    # Small Tools
    vim-visual-increment
  ];
}
