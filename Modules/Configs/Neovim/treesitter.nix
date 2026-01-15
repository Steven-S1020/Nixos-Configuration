{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = (
        nvim-treesitter.withPlugins (p: [
          p.tree-sitter-bash
          p.tree-sitter-cpp
          p.tree-sitter-java
          p.tree-sitter-json
          p.tree-sitter-latex
          p.tree-sitter-lua
          p.tree-sitter-nix
          p.tree-sitter-python
          p.tree-sitter-rust
          p.tree-sitter-sql
          p.tree-sitter-vim
        ])
      );
      type = "lua";
      config # lua
        = ''
          require('nvim-treesitter.config').setup {
            ensure_installed = {},
            auto_install = false,
            highlight = { enable = true },
          }
        '';
    }
  ];
}
