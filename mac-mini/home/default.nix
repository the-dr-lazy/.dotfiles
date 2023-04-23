{ pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.


  # Set nixpkgs options (for home-manager installed packages only).


  # Documentation!
  programs.man.enable = true;
  programs.info.enable = true;

  home.packages = builtins.concatMap builtins.attrValues [
    ###################################################
    # Nix:
    {
      inherit (pkgs)
        cachix
        nix-prefetch-git
        nixpkgs-fmt;
    }

    ###################################################
    # Haskell:
    {
      ghc = pkgs.haskell.compiler.ghc96;

      inherit (pkgs)
        cabal-install
        haskell-language-server
        hlint
        stylish-haskell;
    }

    ###################################################
    # Basic GNU uitls:
    {
      inherit (pkgs)
        automake
        cmake
        # coreutils
        curlFull
        diffutils
        fd
        file
        findutils
        gawk
        glib
        gnumake
        gnupg
        less
        libtool
        mailutils
        watch
        wget;
    }

    ###################################################
    # Command line tools:
    {
      inherit (pkgs)
        act
        bindfs
        cloc
        colordiff
        direnv
        docker-compose
        entr
        git
        harfbuzz
        hledger
        jq
        ledger
        m-cli
        nmap
        pandoc
        pass
        pkg-config
        poppler
        ripgrep
        tldr
        tmate
        tree
        fortune
        cowsay
        lolcat
        starship
        youtube-dl
        pinentry-emacs
        xcpretty;

      inherit (pkgs.nodePackages) zx;
    }

    ###################################################
    # Natural Language:
    {
      inherit (pkgs) languagetool;
      aspell = pkgs.aspellWithDicts (ds: with ds; [ en en-science en-computers fa ]);
    }

    ###################################################
    # Cryptography
    {
      inherit (pkgs)
        bitwarden-cli
        openssh
        openssl;
    }

    ###################################################
    # C
    {
      # inherit (pkgs) gcc llvm;
    }

    ###################################################
    # Ruby
    {
      inherit (pkgs) ruby;
    }

    ###################################################
    # Emacs
    {
      inherit (pkgs)
        delta
        editorconfig-core-c
        pywal
        nodejs-16_x
        sqlite;

      # structured-haskell-mode = pkgs.haskell.lib.justStaticExecutables pkgs.haskellPackages.structured-haskell-mode;
      tex = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; };

      inherit (pkgs.nodePackages)
        typescript-language-server
        bash-language-server
        vscode-langservers-extracted
        vscode-css-languageserver-bin
        yaml-language-server;
    }

    ###################################################
    # Vim
    # {
    #   neovim = pkgs.neovim.override {
    #     viAlias = true;
    #     vimAlias = true;
    #   };
    # }
  ];

  home.file = {
    ".config/starship.toml".source = ../../shared/config/starship.toml;
    ".alacritty.yml".source = ../../shared/config/alacritty.yml;
    ".sqitch/sqitch.conf".source = ../../shared/config/sqitch/config.ini;
    ".gitconfig".source = ../../shared/config/gitconfig.ini;
    ".gitignore".source = ../../shared/config/global.gitignore;
    "Library/Desktop Pictures" = {
      source = ../../shared/wallpapers;
      recursive = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; };
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "bass";
        src = pkgs.fish-plugins.bass;
      }
      {
        name = "foreign-env";
        src = pkgs.fish-plugins.foreign-env;
      }
      {
        name = "bobthefish";
        src = pkgs.fish-plugins.bobthefish;
      }
    ];
    shellInit = builtins.readFile ../../shared/config/fish/config.fish;
  };


}
