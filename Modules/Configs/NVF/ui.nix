{
  ...
}:

{
  programs.nvf = {
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "oxocarbon";
          style = "dark";
        };

        visuals = {
        };

        ui = {
          noice.enable = true;

          borders = {
            enable = true;
            globalStyle = "rounded";

            plugins.nvim-cmp.enable = false;
          };

          smartcolumn = {
            enable = true;

            setupOpts.custom_colorcolumn = {
              nix = "110";
            };
          };
        };
      };
    };
  };
}
