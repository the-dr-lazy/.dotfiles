final: _: {
  env = with final; {
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
