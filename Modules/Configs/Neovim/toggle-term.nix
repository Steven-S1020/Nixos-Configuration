{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      type = "lua";
      config = # lua
        ''
          require'toggleterm'.setup{
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            direction = 'tab',
            shade_terminals = false,
            close_on_exit = true,
            start_in_insert = true,
            auto_scroll = true,
            persist_mode = false,
            shell = vim.o.shell,
          }
        '';
    }
  ];
}
