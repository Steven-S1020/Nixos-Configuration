{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = vim-visual-increment;
      type = "lua";
      config # lua
        = ''
          vim.cmd('set nrformats=alpha,octal,hex')
        '';
    }
  ];
}
