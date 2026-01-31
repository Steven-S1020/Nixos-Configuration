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
    vim-jsx-pretty
    vim-jsx-typescript

    # LSP Support
    nvim-lspconfig

    vimtex

    (pkgs.vimUtils.buildVimPlugin {
      pname = "live-server.nvim";
      version = "2024-12-13";
      src = pkgs.fetchFromGitHub {
        owner = "barrettruth";
        repo = "live-server.nvim";
        rev = "main";
        sha256 = "0hfgcz01l38arz51szbcn9068zlsnf4wsh7f9js0jfw3r140gw6h";
      };
    })

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
