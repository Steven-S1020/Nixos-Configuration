{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes.url = "github:tinted-theming/schemes";
    tt-schemes.flake = false;

    my-schemes.url = "github:Steven-S1020/Base16-Schemes";
    my-schemes.flake = false;

    base16-alacritty.url = "github:aarowill/base16-alacritty";
    base16-alacritty.flake = false;

    base16-vim.url = "github:tinted-theming/base16-vim";
    base16-vim.flake = false;

    base16-gtk.url = "github:tinted-theming/base16-gtk-flatcolor";
    base16-gtk.flake = false;
  };

  outputs = { nixpkgs, self, ... } @ inputs : {
    nixosConfigurations = {
      Azami = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        
        modules = [
          inputs.base16.nixosModule
          { scheme = "${inputs.my-schemes}/Red-Flake.yaml";}
          ./theming.nix

          ./Hosts/Azami.nix
        ];
      };  
    };
  };
}
