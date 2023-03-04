{
  description = "Maulana Sodiqin WSL Config with Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.beast = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        modules/systems
	home-manager.nixosModules.home-manager {
	   home-manager.useGlobalPkgs = true;
	   home-manager.useUserPackages = true;
	   home-manager.users.ms = {config, pkgs, lib, ...}: {
	     imports = [
	     	./modules/users
	     ];
	   };
	}
      ];
    }; 
  };
}
