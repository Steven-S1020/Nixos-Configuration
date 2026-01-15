{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/899dc449bc6428b9ee6b3b8f771ca2b0ef945ab9";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        Azami = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };

          modules = [
            # Host
            ./Hosts/Azami.nix

            # Surface Hardware
            nixos-hardware.nixosModules.microsoft-surface-common

            # Theming
            stylix.nixosModules.stylix
          ];
        };

        Deimos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };

          modules = [
            # Host
            ./Hosts/Deimos.nix

            # Theming
            stylix.nixosModules.stylix
          ];
        };

        Vigil = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit (inputs) nixpkgs home-manager nixos-hardware;
          };

          modules = [
            # Host
            ./Hosts/Vigil.nix

          ];
        };
      };

      devShells.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          lib = pkgs.lib;

          # Helper function to create a shell with a custom prompt
          mkShellWithPrompt =
            name: rgb: attrs:
            pkgs.mkShell (
              attrs
              // {
                shellHook = ''
                  export PS1="\[\e[37m\]|\[\e[${rgb}m\]\u@\h\[\e[37m\]|\[\e[${rgb}m\] ${name} \[\e[37m\]|\[\e[${rgb}m\] \w \[\e[37m\]󱎃\n󰇜󰇜 \[\e[0m\]"
                  echo ""
                  echo "Development shell: ${name}"
                  echo "Available packages:"
                  ${
                    lib.concatMapStringsSep "\n" (
                      pkg:
                      ''command -v ${pkg.pname or pkg.name or "unknown"} >/dev/null && echo "  - ${
                        pkg.pname or pkg.name or "unknown"
                      }: $(${
                        pkg.pname or pkg.name or "unknown"
                      } --version 2>&1 | head -n1 | sed 's/ from.*//' || echo 'version unknown')"''
                    ) (attrs.buildInputs or [ ])
                  }                  echo ""
                  ${attrs.shellHook or ""}
                '';
              }
            );
        in
        {
          dsci-Python = mkShellWithPrompt "DSCI-Python" "38;2;169;151;223" {
            buildInputs = with pkgs.python313Packages; [
              pkgs.python313
              marimo
              matplotlib
              numpy
              pandas
              pip
              python-lsp-server
              seaborn
              scipy
              sympy
            ];
          };
          dsci-PyRJul = mkShellWithPrompt "DSCI-PyRJul" "38;2;179;246;192" {
            buildInputs =
              with pkgs;
              [
                R
                python313
                (julia-bin.withPackages [
                  "DataFrames"
                  "Plots"
                  "SciMLBase"
                  "StatsBase"
                ])
                (rstudioWrapper.override {
                  packages = with pkgs.rPackages; [
                    RColorBrewer
                    dplyr
                    ggplot2
                    reshape2
                  ];
                })
              ]
              ++ (with python313Packages; [
                numpy
                pandas
                scikit-learn
                scipy
                tensorflow
              ]);
          };
        };
    };
}
