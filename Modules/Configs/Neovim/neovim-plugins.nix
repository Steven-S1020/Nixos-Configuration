{ pkgs }:

with pkgs.vimPlugins; [
  # Utilities
  neo-tree-nvim
  telescope-nvim
  
  # Looks
  nvim-web-devicons
  nvim-treesitter.withAllGrammars
  
  # Language Servers and completion
  nvim-jdtls
  coc-pyright
  coc-clangd
  coc-ultisnips
]
