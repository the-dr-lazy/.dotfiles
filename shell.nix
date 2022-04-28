{ pkgs, ... }:

pkgs.mkShell {
  name = ".dotfiles";

  nativeBuildInputs = builtins.concatMap builtins.attrValues [
    ###################################################
    # Code styles:
    {
      inherit (pkgs) pre-commit nixpkgs-fmt nix-linter shfmt shellcheck;
      inherit (pkgs.unstable.python310Packages) pre-commit-hooks yamllint;
      inherit (pkgs.nodePackages) prettier;
    }

    ###################################################
    # Command line tools:
    { inherit (pkgs) gitFull; }

    ###################################################
    # Language servers:
    {
      inherit (pkgs.nodePackages)
        bash-language-server
        vscode-json-languageserver-bin
        yaml-language-server;
    }
  ];
}
