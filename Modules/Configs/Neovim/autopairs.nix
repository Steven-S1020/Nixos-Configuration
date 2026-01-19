{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = /* lua */ ''
        ---[ Autopairs ]---
        require'nvim-autopairs'.setup()
      '';
    }
  ];
}
