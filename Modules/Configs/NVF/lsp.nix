{
  pkgs,
  ...
}:

{
  programs.nvf = {
    settings = {
      vim = {
        lsp = {
          enable = true;
          servers.nixd.settings.nil.nix.autoArchive = false;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          java.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          sql.enable = true;
          r.enable = true;
          ts = {
            enable = true;
            lsp.servers = ["ts_ls"];
            format.type = ["prettier"];
            extraDiagnostics.types = ["eslint_d"];
          };
          julia.lsp = {
            enable = true;
            servers = pkgs.julia-bin;
          };
        };
      };
    };
  };
}
