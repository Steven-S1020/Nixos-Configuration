{ config, pkgs, lib, ... }:

let
  # Import separate configuration files
  neovimPlugins = import ./neovim-plugins.nix { inherit pkgs; };
  neovimKeybindings = import ./neovim-keybindings.nix;
  neovimLsp = import ./neovim-lsp.nix;
  neovimSettings = import ./neovim-settings.nix;
in

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

      # Additional configuration
      extraLuaConfig = neovimKeybindings + neovimSettings + neovimLsp;

      extraConfig = ''
        " Snippet
        let g:UltiSnipsSnippetDirectories=['/etc/nixos/Modules/Configs/Snippets']
        let g:UltiSnipsExpandTrigger = '<tab>'
        let g:UltiSnipsJumpForwardTrigger = '<tab>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
      '';

      # Add plugins from the separate plugins configuration file
      plugins = neovimPlugins;
    };
  };
}
