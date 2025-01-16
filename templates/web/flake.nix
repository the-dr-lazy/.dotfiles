{
  description = "Web development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/d4191fe35cbe52f755ef73009d4d37b9e002efa2";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/d59dd43e49f24b58fe8d5ded38cbdf00c3da4dc2";
    utils.url = "github:numtide/flake-utils";
    easy-purescript-src = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, utils, easy-purescript-src, ... }:
    let name = "web-template";
    in
    utils.lib.eachDefaultSystem (system:
      let
        easy-purescript = import easy-purescript-src { inherit pkgs; };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (_: _: {
              inherit (easy-purescript) purs-tidy pulp purescript-language-server;
              purescript = easy-purescript.purs-0_15_0;
              unstable = import nixpkgs-unstable { inherit system; };
            })
          ];
        };
      in
      {
        devShell = import ./shell.nix {
          inherit name pkgs;
        };
      });
}
