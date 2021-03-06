{
  description = "Web development environment";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    easy-purescript-src = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, easy-purescript-src, utils, ... }:
    let name = throw "Put your package name here.";
    in
    utils.lib.eachDefaultSystem (system:
      let
        easy-purescript = import easy-purescript-src { pkgs = pkgs.stable; };
        pkgs = {
          stable = import nixpkgs-stable {
            inherit system;
            overlays = [ (_: _: { inherit (easy-purescript) purs-tidy; }) ];
          };
          unstable = import nixpkgs-unstable { inherit system; };
        };
      in
      {
        devShell = import ./shell.nix {
          inherit name pkgs;
        };
      });
}
