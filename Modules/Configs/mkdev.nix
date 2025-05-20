{
  inputs,
  ...
}:

{
  home-manager.users.steven = {
    imports = [
      inputs.mkdev.homeManagerModule
    ];

    programs.mkdev = {
      enable = true;

      config = {
        recipe_dir = "/home/steven/.config/mkdev/recipes";

        subs = {
          day = "date +%d";
          dir = "mk::dir";
          month = "date +%m";
          pc_name = "hostname --fqdn";
          user = "whoami";
          year = "date +%Y";
        };
      };

      recipes = [
        {
          name = "DSCI";
          description = "";
          languages = [
            "[38;2;126;126;255mNix[0m"
          ];
          contents = [
            {
              name = "flake.nix";
              content = ''
                {
                  description = "Flake for {{name}} Project";

                  inputs.system-flake.url = "path:/etc/nixos";
                  inputs.nixpkgs.follows = "system-flake/nixpkgs";

                  outputs =
                    { system-flake, nixpkgs, ... }:
                    let
                      system = "x86_64-linux";
                      pkgs = import nixpkgs { inherit system; };

                      # Base devShell to use
                      base = system-flake.devShells.''${system}.dsci;
                    in
                    {
                      devShells.''${system}.default = pkgs.mkShell {
                        # Extra Packages not included in base devShell
                        buildInputs = base.buildInputs ++ [
                          # Add Packages Here
                        ];
                      };
                    };
                }

              '';
            }
          ];
        }
      ];
    };
  };
}
