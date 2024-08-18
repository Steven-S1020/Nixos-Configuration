{ config, pkgs, inputs, ...}:

{
  home-manager.users.steven = {

  
    # Theme 'alacritty'
    programs.alacritty.settings.colors = 
      with config.scheme.withHashtag; let default = {
        black = base00; white = base05;
        inherit red green yellow blue cyan magenta;  
      };
    in {
      primary = { background = base00; foreground = base05; };
      cursor = { text = base02; cursor = base07; };
      normal = default; bright = default; dim = default;
    };

    # Theme 'neovim'
    programs.neovim = {
      plugins = [ (pkgs.vimPlugins.base16-vim.overrideAttrs (old:
        let schemeFile = config.scheme inputs.base16-vim;
        in { patchPhase = "cp ${schemeFile} colors/base16-scheme.vim"; }
      ))];
      extraConfig = "
        set termguicolors background=dark
        let base16colorspace=256
        colorscheme base16-scheme
      ";  
    };

    # Theme 'gtk'
    # gtk = builtins.readFile (config.scheme {
    #   templateRepo = inputs.base16-gtk; target = "gtk-3";
    # });
  };
}