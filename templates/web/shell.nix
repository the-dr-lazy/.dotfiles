{ pkgs, name }:

pkgs.mkShell {
  inherit name;

  nativeBuildInputs = builtins.concatMap builtins.attrValues [
    ###################################################
    # Code styles:
    {
      inherit (pkgs) pre-commit nixpkgs-fmt nix-linter shfmt shellcheck;
      inherit (pkgs.python3Packages) pre-commit-hooks yamllint;
      inherit (pkgs.nodePackages) prettier;

      headroom = pkgs.haskell.lib.justStaticExecutables pkgs.haskellPackages.headroom;
    }

    ###################################################
    # Command line tools:
    { inherit (pkgs) gitFull git-lfs; }

    ###################################################
    # Languages:
    {
      inherit (pkgs) dhall purescript nodejs-16_x;
      inherit (pkgs.nodePackages) typescript;
    }

    ###################################################
    # Language servers:
    {
      inherit (pkgs) dhall-lsp-server;
      inherit (pkgs.nodePackages)
        bash-language-server
        purescript-language-server
        typescript-language-server
        vscode-html-languageserver-bin
        vscode-json-languageserver-bin
        yaml-language-server;
    }

    ###################################################
    # Package managers:
    { inherit (pkgs) spago; }
  ];
}
