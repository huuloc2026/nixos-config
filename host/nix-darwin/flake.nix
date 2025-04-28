{
  description = "Dotfiles for Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }: 
    let
      system = "aarch64-darwin"; 
    in {
      darwinConfigurations."darwin" = darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin/system.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."jakeonyx" = import ./darwin/home.nix;
          }
        ];
      };
    };
}
