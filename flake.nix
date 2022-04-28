{
  description = "amygdala :: ∀ a. a → IO Memory's Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a3917caedfead19f853aa5769de4c3ea4e4db584";
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

  outputs = { nixpkgs, nixpkgs-unstable, utils, home-manager, darwin, ... }:
    let
      macBookAir = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          (import ./mac-book-air/system)
        ];
      };
      macMini = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          (import ./mac-mini/system)
        ];
      };
    in
    {
      #################################################
      # Systems
      #
      packages.x86_64-darwin.darwinConfigurations.Mohammads-MacBook-Air = macBookAir;
      packages.x86_64-darwin.darwinConfigurations.MacBook-Air = macBookAir;

      packages.aarch64-darwin.darwinConfigurations.Mohammads-Mac-mini = macMini;
      packages.aarch64-darwin.darwinConfigurations.Mac-mini = macMini;

      #################################################
      # Templates
      #
      templates.web = {
        path = ./templates/web;
        description = "Web development environment.";
      };
      templates.node = {
        path = ./templates/node;
        description = "Node JS development environment.";
      };
    } // utils.lib.eachDefaultSystem (system: {
      devShell = import ./shell.nix {
        inherit system; pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (_: _: {
            unstable = import nixpkgs-unstable { inherit system; };
          })
        ];
      };
      };
    });
}
