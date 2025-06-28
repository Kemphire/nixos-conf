{
  description = "flake config for my machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles_imper = {
      url = "git+file:dotfiles_imper";
      flake = false;
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ...
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      kapil = lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          {
            environment.extraOutputsToInstall = ["dev"];

            environment.variables.C_INCLUDE_PATH = "${pkgs.expat.dev}/include";
          }
        ];
      };
    };
    homeConfigurations = {
      hitmonlee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
