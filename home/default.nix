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

  imports = [ ./config.nix ./shell.nix ];

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
        niv
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
        youtube-dl;

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

      text = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; };
    }

    ###################################################
    # Vim
    { inherit (pkgs) vim; }
  ];

  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; enableFlakes = true; };
  };
}
