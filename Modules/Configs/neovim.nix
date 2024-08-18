# Neovim Configuration

{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    nixd
    clang-tools
  ];


  home-manager.users.steven = {
    programs.neovim = {

      enable = true;

      viAlias = true;
      vimAlias = true;

      coc = {
        enable = true;

        settings = {
          "suggest.noselect" = true;
          "suggest.enablePreview" = true;
          "suggest.enablePreselect" = false;
          "suggest.disableKind" = true;
          "inlayHint.enable" = false;

          languaseserver = {
            nix = {
              command = "nixd";
              filetype = [ "nix" ];
            };
          };
        };
      };

      # Plugins
      plugins = with pkgs.vimPlugins; [
        neo-tree-nvim
        telescope-nvim

        coc-pyright
        coc-clangd
      ];

      extraLuaConfig = ''
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.mouse = 'a'

        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true

        vim.opt.number = true
        vim.opt.relativenumber = true

        vim.opt.incsearch = true
        vim.opt.hlsearch = true
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        vim.api.nvim_create_user_command('FF', 'Telescope find_files', {})
        vim.cmd('cnoreabbrev ff FF')
        vim.api.nvim_create_user_command('NT', 'Neotree', {})
        vim.cmd('cnoreabbrev nt NT')

        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.cmd("Neotree")
            vim.cmd("wincmd p")
          end  
        })
      '';
    };
  };
}
