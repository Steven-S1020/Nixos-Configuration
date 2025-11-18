{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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
      inputs.quickshell.follows = "quickshell";
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
      };

      devShells.x86_64-linux = {
        dsci =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in
          pkgs.mkShell {
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
      };
    };
}
