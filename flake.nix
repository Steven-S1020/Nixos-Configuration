{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixpkgs, nixos-hardware, stylix, ... }@inputs:
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
    };
}
