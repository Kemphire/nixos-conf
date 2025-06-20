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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    dotfiles_imper,
    ...
  }: let
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
        modules = [./configuration.nix];
      };
    };
    homeConfigurations = {
      hitmonlee = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix

          {
            _module.args.dotfiles = dotfiles_imper;
          }
        ];
      };
    };
  };
}
