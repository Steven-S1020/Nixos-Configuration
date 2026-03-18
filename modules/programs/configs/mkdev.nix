{ inputs, ... }:
{
  den.aspects.programs._.mkdev.homeManager =
    { ... }:
    let
      envrc = {
        name = ".envrc";
        content = "use flake";
      };
    in
    {
      imports = [ inputs.mkdev.homeManagerModules.default ];

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
            name = "Empty-Flake";
            description = "";
            languages = [
              {
                name = "Nix";
                colour = [
                  156
                  207
                  216
                ];
              }
            ];
            contents = [
              envrc
              {
                name = "flake.nix";
                content = /* nix */ ''
                  {
                    description = "Empty Flake";
                    inputs = {
                      system-flake.url = "path:/etc/nixos";
                      nixpkgs.follows = "system-flake/nixpkgs";
                    };

                    outputs =
                      { nixpkgs, ... }:
                      {
                        devShells.''${system}.default = pkgs.mkShellNoCC {
                          name = "Empty Flake";

                          buildInputs = with pkgs; [
                          ];

                          shellHook = '''
                          ''';
                        };
                      };
                  }

                '';
              }
            ];
          }
          {
            name = "R-Flake";
            description = "";
            languages = [
              {
                name = "Nix";
                colour = [
                  156
                  207
                  216
                ];
              }
            ];
            contents = [
              envrc
              {
                name = "flake.nix";
                content = /* nix */ ''
                  {
                    description = "Basic R Flake";
                    inputs = {
                      system-flake.url = "path:/etc/nixos";
                      nixpkgs.follows = "system-flake/nixpkgs";
                    };

                    outputs =
                      { nixpkgs, ... }:
                      let
                        system = "x86_64-linux";
                        pkgs = import nixpkgs { 
                            inherit system;
                            config.allowUnfree = true;
                          };
                        myRPackages = with pkgs.rPackages; [
                          ISLR2
                          RColorBrewer
                          dplyr
                          ggplot2
                          lmtest
                          reshape2
                          rmarkdown
                          nortest
                          writexl
                        ];
                        myR = pkgs.rWrapper.override { packages = myRPackages; };
                        myRStudio = pkgs.rstudioWrapper.override { packages = myRPackages; };
                      in
                      {
                        devShells.''${system}.default = pkgs.mkShellNoCC {
                          name = "R Flake";

                          buildInputs = [
                            myR
                            myRStudio
                          ];

                          shellHook = '''
                            alias rs="rstudio > /dev/null 2>&1 &"
                          ''';
                        };
                      };
                  }

                '';
              }
            ];
          }
          {
            name = "WebDev-Flake";
            description = "";
            languages = [
              {
                name = "Nix";
                colour = [
                  156
                  207
                  216
                ];
              }
            ];
            contents = [
              envrc
              {
                name = "flake.nix";
                content = /* nix */ ''
                  {
                    description = "Basic Webdev (MERN) Flake";
                    inputs = {
                      system-flake.url = "path:/etc/nixos";
                      nixpkgs.follows = "system-flake/nixpkgs";
                    };

                    outputs =
                      { nixpkgs, ... }:
                      let
                        system = "x86_64-linux";
                        pkgs = import nixpkgs { 
                            inherit system;
                            config.allowUnfree = true;
                          };
                      in
                      {
                        devShells.''${system}.default = pkgs.mkShellNoCC {
                          name = "Webdev Flake";
                          
                          buildInputs = with pkgs; [
                            live-server
                            nodejs_22
                            nodePackages.npm
                            mongodb-ce
                            mongosh
                            postman
                          ];

                          shellHook = '''
                          ''';
                        };
                      };
                  }

                '';
              }
            ];
          }
          {
            name = "RPyJul-Flake";
            description = "";
            languages = [
              {
                name = "Nix";
                colour = [
                  156
                  207
                  216
                ];
              }
            ];
            contents = [
              envrc
              {
                name = "flake.nix";
                content = /* nix */ ''
                  {
                    description = "Basic R, Python, and Julia Flake";
                    inputs = {
                      system-flake.url = "path:/etc/nixos";
                      nixpkgs.follows = "system-flake/nixpkgs";
                    };

                    outputs =
                    { nixpkgs, ... }:
                      let
                        system = "x86_64-linux";
                        pkgs = import nixpkgs { 
                            inherit system;
                            config.allowUnfree = true;
                          };
                        myRPackages = with pkgs.rPackages; [
                          ISLR2
                          RColorBrewer
                          dplyr
                          ggplot2
                          lmtest
                          reshape2
                          rmarkdown
                          nortest
                          writexl
                        ];
                        myR = pkgs.rWrapper.override { packages = myRPackages; };
                        myRStudio = pkgs.rstudioWrapper.override { packages = myRPackages; };
                      in
                      {
                        devShells.''${system}.default = pkgs.mkShellNoCC {
                          name = "RPyJul Flake";

                          buildInputs = [
                            myR
                            myRStudio
                            python313
                            (julia-bin.withPackages [
                              "CSV"
                              "DataFrames"
                              "HTTP"
                              "Plots"
                              "SciMLBase"
                              "StatsBase"
                              "XLSX"
                            ])
                          ]
                          ++ (with python313Packages; [
                            marimo
                            matplotlib
                            numpy
                            openpyxl
                            pandas
                            pip
                            python-lsp-server
                            requests
                            scikit-learn
                            scipy
                            seaborn
                            sympy
                            tensorflow
                          ]);

                          shellHook = '''
                            alias rs="rstudio > /dev/null 2>&1 &"
                          ''';
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
