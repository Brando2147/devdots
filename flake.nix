{
  description = "Brando's NixOS and MacOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:Brando2147/devdots/main";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, darwin, home-manager, nixpkgs, ... }@inputs: {
    # My Macbook Pro 16"
    darwinConfigurations = {
      "Brandos-MBP" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
        ];
        inputs = { inherit darwin home-manager nixpkgs; };
      };
     };

    # My NixOS machine
    nixosConfigurations = {
      bnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos
          ./hardware/bnix.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.brando = import ./nixos/home-manager.nix;
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}