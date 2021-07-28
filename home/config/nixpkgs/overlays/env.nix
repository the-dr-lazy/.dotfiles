final: _: {
  env = with final; {
    web = buildEnv {
      name = "web-env";
      paths = [
        nodejs
        purescript
        spago
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.vscode-html-languageserver-bin
        nodePackages.vscode-css-languageserver-bin
        nodePackages.yaml-language-server
        nodePackages.purescript-language-server
        nodePackages.prettier
      ];
    };

    haskell = buildEnv {
      name = "haskell-env";
      paths =
        let
          haskellPackages = haskell.packages.ghc901;
          justStaticExecutables = haskell.lib.justStaticExecutables;
        in
        [
          haskell.compiler.ghc901
          (justStaticExecutables haskellPackages.ghcid)
          haskell-language-server
          hlint
          stylish-haskell
          cabal2nix
        ];
    };
  };
}
