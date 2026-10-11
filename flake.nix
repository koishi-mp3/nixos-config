{
  description = "Crappy config that I made";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    slippi.url = "github:lytedev/slippi-nix";
    slippi.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, agenix, nixpkgs-xr, ... }: {
    nixosConfigurations.nixstrogen = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/koishi/configuration.nix
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.koishi = import ./hosts/koishi/home.nix;
        }
      ];
    };

    nixosConfigurations.blahaj = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/cirno/configuration.nix
	home-manager.nixosModules.home-manager
	agenix.nixosModules.default
	nixpkgs-xr.nixosModules.nixpkgs-xr
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.cirno = import ./hosts/cirno/home.nix; 
        }
        {
          nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
        }
      ];
    };
  };
}
