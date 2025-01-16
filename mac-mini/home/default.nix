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
      ghc = pkgs.unstable.haskell.compiler.ghc984;

      # Failed to heat cache...
      #
      # haskell-language-server = pkgs.haskell-language-server.override {
      #    supportedGhcVersions = [ "966" ];
      # };

      llvm = pkgs.llvmPackages_15.llvm;

      inherit (pkgs)
        cabal-install
        hlint
        ghcid
        stylish-haskell;
    }

    ###################################################
    # Basic GNU uitls:
    {
      inherit (pkgs)
        automake
        cmake
        coreutils-prefixed
        diffutils
        findutils
        curlFull
        fd
        file
        gawk
        # glib
        gnumake
        less
        # libtool
        watch
        wget;
    }

    ###################################################
    # Command line tools:
    {
      inherit (pkgs)
        act
        cloc
        colordiff
        direnv
        git
        harfbuzz
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
        yt-dlp 
        xcpretty
        imagemagick
        inetutils
        parallel-full;

      inherit (pkgs.nodePackages) zx;
    }

    ###################################################
    # Natural Language:
    {
      inherit (pkgs) languagetool;
      aspell = pkgs.aspellWithDicts (ds: with ds; [ en en-science en-computers fa ]);
    }

    ###################################################
    # C
    {
      # inherit (pkgs) gcc llvm;
    }

    ###################################################
    # Ruby
    {
      # inherit (pkgs) ruby;
    }


    ###################################################
    # Android
    {
      inherit (pkgs) scrcpy;
    }

    ###################################################
    # Emacs
    {
      inherit (pkgs)
        emacs-lsp-booster
        delta
        editorconfig-core-c
        pywal
        nodejs_22
        sqlite
        tailwindcss-language-server;

      # tex = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; };

      inherit (pkgs.nodePackages)
        typescript-language-server
        typescript
        bash-language-server
        vscode-langservers-extracted
        yaml-language-server;

    }
  ];

  home.file = {
    ".config/starship.toml".source = ../../shared/config/starship.toml;
    ".alacritty.toml".source = ../../shared/config/alacritty.toml;
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
