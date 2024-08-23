{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, self, nixos-hardware, ... } @ inputs : {
    nixosConfigurations = {
      Azami = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        
        modules = [
          # Theming
          inputs.stylix.nixosModules.stylix
          
          # Surface Hardware
          nixos-hardware.nixosModules.microsoft-surface-common

          # Host
          ./Hosts/Azami.nix
        ];
      };  
    };
  };
}
