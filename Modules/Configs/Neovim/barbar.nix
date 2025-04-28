{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = barbar-nvim;
      type = "lua";
      config = # lua
        ''
          map('n', '<S-Tab>', ':BufferNext<CR>')
          map('n', '<S-w>', ':BufferClose<CR>')
        '';
    }
  ];
}
