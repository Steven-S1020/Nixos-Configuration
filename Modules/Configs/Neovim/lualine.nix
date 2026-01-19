{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = /* lua */ ''
        ---[ Lualine ]---
        require'lualine'.setup {
          options = {
            theme = 'horizon',
            globalstatus = 'true'
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'lsp_status' },
            lualine_z = { 'selectioncount', 'location' }
          }
        }
      '';
    }
  ];
}
