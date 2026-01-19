{
  pkgs,
  ...
}:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-surround;
      type = "lua";
      config = /* lua */ ''
          ---[ Surround ]---
        local surround = require'nvim-surround'

        surround.setup()
      '';
    }
  ];
}
