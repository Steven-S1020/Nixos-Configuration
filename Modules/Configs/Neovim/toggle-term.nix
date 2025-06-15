{ pkgs, ... }:

{
  home-manager.users.steven.programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      type = "lua";
      config # lua
        = ''
          require("toggleterm").setup {
            size = 20,
            open_mapping = [[<c-\\>]], -- escape backslash inside Nix string
            direction = "float",
            hide_numbers = true,
            shade_terminals = false,
            close_on_exit = true,
            start_in_insert = true,
            auto_scroll = true,
            persist_mode = false,
          }
        '';
    }
  ];
}
