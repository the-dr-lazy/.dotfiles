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
    # Basic GNU uitls:
    {
      inherit (pkgs)
        automake
        cmake
        coreutils
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
        pinentry-emacs;

      inherit (pkgs.nodePackages) prettier;
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
      inherit (pkgs) gcc llvm;
    }

    ###################################################
    # Emacs
    {
      inherit (pkgs)
        delta
        editorconfig-core-c
        pywal
        sqlite;

      structured-haskell-mode = pkgs.haskell.lib.justStaticExecutables pkgs.haskellPackages.structured-haskell-mode;
      text = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; };
    }

    ###################################################
    # Vim
    { inherit (pkgs) vim; }
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
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "refs/heads/master";
          sha256 = "0mb01y1d0g8ilsr5m8a71j6xmqlyhf8w4xjf00wkk8k41cz3ypky";
        };
      }
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "626bd39b002535d69e56adba5b58a1060cfb6d7b";
          sha256 = "06whihwk7cpyi3bxvvh3qqbd5560rknm88psrajvj7308slf0jfd";
        };
      }
    ];
    shellInit = builtins.readFile ../../shared/config/fish/config.fish;
  };


}
