{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = ultisnips;
      type = "lua";
      config # lua
        = ''
          vim.g.UltiSnipsSnippetDirectories={'/etc/nixos/Modules/Configs/Snippets/'}
          vim.g.UltiSnipsExpandTrigger = '<tab>'
          vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
          vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
        '';
    }
  ];
}
