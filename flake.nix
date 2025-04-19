{
  description = "My Flakes - Jake Onyx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; 
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./host/i3/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      jakeonyx = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # ./home-manager/home.nix
          ./desktop/i3/i3.nix
        ];
      };
    };
  };
}

