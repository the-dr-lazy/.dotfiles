{
  description = "Web development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-21.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    let name = throw "Put your package name here.";
    in
    utils.lib.eachDefaultSystem (system: {
      devShell = import ./shell.nix {
        inherit name;
        pkgs = import nixpkgs { inherit system; };
      };
    });
}
