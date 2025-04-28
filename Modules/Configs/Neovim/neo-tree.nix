{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = neo-tree-nvim;
      type = "lua";
      config # lua
        = ''
          vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
          vim.cmd('cnoreabbrev nt NT')

          -- close if last open
          require'neo-tree'.setup({
            close_if_last_window = true,
          })
        '';
    }
  ];
}
