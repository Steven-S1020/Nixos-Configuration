{ pkgs, ... }:

{
  # Ensure system packages needed are included
  environment.systemPackages = with pkgs; [
    nixd
    clang-tools
    python3Packages.black
    jdt-language-server
    google-java-format
    ripgrep
  ];

  home-manager.users.steven = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      
      coc = {
        enable = true;

        settings = {
          "suggest.noselect" = true;
          "suggest.enablePreview" = true;
          "suggest.enablePreselect" = false;
          "suggest.disableKind" = true;
          "inlayHint.enable" = false;
          "python.analysis.autoImportCompletions" = false;
          
        languageserver = {
          nix = {
            command = "nixd";
            filetypes = [ "nix" ];
          };
        };
      };
    };

      # Add plugins from the separate plugins configuration file
      plugins = with pkgs.vimPlugins; [
        # Utilities
        neo-tree-nvim
        telescope-nvim
        ultisnips

        # Looks
        nvim-web-devicons
        nvim-treesitter.withAllGrammars

        # Language Servers
        coc-pyright
        coc-clangd  
        coc-ultisnips
      ];

    # Additional configuration
    extraLuaConfig = ''
      
      -- Telescope Keybinds
      vim.api.nvim_create_user_command('FF', 'Telescope find_files', {})
      vim.cmd('cnoreabbrev ff FF')
      vim.api.nvim_create_user_command('FG', 'Telescope live_grep', {})
      vim.cmd('cnoreabbrev fg FG')

      -- Neotree Keybinds
      vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
      vim.cmd('cnoreabbrev nt NT')

      -- Clipboard Stuff
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.mouse = 'a'

      -- Tabs
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Line Numbers 
      vim.opt.number = true
      vim.opt.relativenumber = true

      -- Search Config
      vim.opt.incsearch = true
      vim.opt.hlsearch = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Neotree Config
      require("neo-tree").setup({
        close_if_last_window = true,
      })

      -- Launch Config
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd("wincmd p")
          if vim.fn.argv(0) == "" then
            require("telescope.builtin").find_files()
            end
        end  
      })
      
      -- Java Slight Syntax Highlighting
      vim.cmd[[
        let java_highlight_function = 1
        let java_highlight_all = 1
        set filetype=java
        highlight link javaScopeDecl Statement
        highlight link javaType Type
        highlight link javaDocTags PreProc
      ]]

      -- Python Treesitter Settings
      require'nvim-treesitter.configs'.setup {
        parser_install_dir = '/etc/nixos/Modules/Configs/Neovim/Parsers',
        ensure_installed = none,
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
      vim.opt.runtimepath:append('/etc/nixos/Modules/Configs/Neovim/Parsers')

    '';

      extraConfig = ''
        " Snippet
        let g:UltiSnipsSnippetDirectories=['/etc/nixos/Modules/Configs/Snippets']
        let g:UltiSnipsExpandTrigger = '<tab>'
        let g:UltiSnipsJumpForwardTrigger = '<tab>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
      '';

    };
  };
}
