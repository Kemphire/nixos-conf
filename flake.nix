{
	description = "flake config for my machines";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {self, nixpkgs,home-manager, ...}:
	let 
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		};
	in
	{
		nixosConfigurations = {
			kapil = lib.nixosSystem {
				inherit system;
				modules = [./configuration.nix];
			};
		};
		homeConfigurations = {
			hitmonlee = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [./home.nix];
			};
		};
		home-manager.backupFileExtension = "backup";

	};
}
