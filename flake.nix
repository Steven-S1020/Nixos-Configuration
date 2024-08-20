{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, self, ... } @ inputs : {
    nixosConfigurations = {
      Azami = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        
        modules = [
          # Theming
          inputs.stylix.nixosModules.stylix

          # Host
          ./Hosts/Azami.nix
        ];
      };  
    };
  };
}
