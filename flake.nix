{
  description = "amygdala :: ∀ a. a → IO Memory's Mac OS X";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, utils, home-manager, darwin, ... }:
    {
      packages.x86_64-darwin.darwinConfigurations.Mohammads-Air = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          (import ./system)
        ];
      };

      templates.web = {
        path = ./templates/web;
        description = "Web development environment";
      };
    } // utils.lib.eachDefaultSystem (system: {
      devShell = import ./shell.nix { inherit system; pkgs = import nixpkgs { inherit system; }; };
    });
}
