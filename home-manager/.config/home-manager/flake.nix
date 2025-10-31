{
  description = "Home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = { nixpkgs, home-manager, vicinae, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."msyavuz" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix vicinae.homeManagerModules.default ];
      };
    };
}

