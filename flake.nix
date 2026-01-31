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
            ./Hosts/Azami/Azami.nix

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
            ./Hosts/Deimos/Deimos.nix

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
            ./Hosts/Vigil/Vigil.nix

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
                  alias rs="rstudio > /dev/null 2>&1 &"
                  export PS1="\[\e[37m\]|\[\e[${rgb}m\]\u@\h\[\e[37m\]|\[\e[${rgb}m\] ${name} \[\e[37m\]|\[\e[${rgb}m\] \w \[\e[37m\]󱎃\n󰇜󰇜 \[\e[0m\]"
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
          dsci-PyRJul = mkShellWithPrompt "DSCI-PyRJul" "38;2;179;246;192" {
            buildInputs =
              with pkgs;
              let
                myRPackages = with rPackages; [
                  ISLR2
                  RColorBrewer
                  dplyr
                  ggplot2
                  reshape2
                  rmarkdown
                ];
                myR = rWrapper.override { packages = myRPackages; };
                myRStudio = rstudioWrapper.override { packages = myRPackges; };
              in
              [
                myR
                myRStudio
                python313
                (julia-bin.withPackages [
                  "CSV"
                  "DataFrames"
                  "Plots"
                  "SciMLBase"
                  "StatsBase"
                ])
              ]
              ++ (with python313Packages; [
                marimo
                matplotlib
                numpy
                numpy
                pandas
                pandas
                pip
                python-lsp-server
                requests
                scikit-learn
                scipy
                scipy
                seaborn
                sympy
                tensorflow
              ]);
          };
        };
    };
}
