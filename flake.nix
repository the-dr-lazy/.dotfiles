{
  description = "amygdala :: ∀ a. a → IO Memory's Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    fish-bass = {
      url = "github:edc/bass";
      flake = false;
    };
    fish-foreign-env = {
      url = "github:oh-my-fish/plugin-foreign-env";
      flake = false;
    };
    fish-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, utils, home-manager, darwin, fish-bass, fish-foreign-env, fish-bobthefish, ... }:
    let
      macBookAir = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          (import ./mac-book-air/system)
        ];
      };
      macMini = darwin.lib.darwinSystem {
        pkgs = import nixpkgs-unstable {
          system = "aarch64-darwin";
          overlays = [
            (_: _: {
              fish-plugins = {
                bass = fish-bass;
                foreign-env = fish-foreign-env;
                bobthefish = fish-bobthefish;
              };
            })
          ];
          config = {
            allowUnfree = true;
            allowBroken = false;
            allowUnsupportedSystem = false;
          };
        };
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
      packages.x86_64-darwin.darwinConfigurations.Mohammads-Air = macBookAir;
      packages.x86_64-darwin.darwinConfigurations.MacBook-Air = macBookAir;

      packages.aarch64-darwin.darwinConfigurations.Mohammads-Mac-mini = macMini;
      packages.aarch64-darwin.darwinConfigurations.Mohammads-Mini = macMini;
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
