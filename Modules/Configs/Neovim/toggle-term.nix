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
            shade_terminals = false,
            auto_scroll = true,
            persist_mode = false,
          }

          vim.api.nvim_create_user_command("TabTerm", function()
            require("toggleterm.terminal").Terminal:new({ 
              direction = 'tab',
              cmd = 'ls',
            }):open()
          end, {})

          function _G.set_terminal_keymaps()
            local opts = {buffer = 0}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
          end

        '';
    }
  ];
}
