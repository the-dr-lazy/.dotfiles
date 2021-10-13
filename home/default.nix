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
        nixpkgs-fmt
        nix-prefetch-git
        niv
        cachix;
    }

    ###################################################
    # Basic GNU uitls:
    {
      inherit (pkgs)
        coreutils
        findutils
        diffutils
        mailutils
        gawk
        gnumake
        automake
        less
        watch
        wget
        curlFull
        fd
        file
        gnupg
        glib
        cmake
        libtool;
    }

    ###################################################
    # Command line tools:
    {
      inherit (pkgs)
        colordiff
        pkg-config
        bindfs
        direnv
        cloc
        entr
        harfbuzz
        ripgrep
        pass
        poppler
        youtube-dl
        jq
        tree
        tldr
        tmate
        act
        m-cli
        git
        ledger
        hledger
        docker-compose

        ;
      inherit (pkgs.stable.nodePackages) prettier;
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
      inherit (pkgs) gcc
        llvm;
    }

    ###################################################
    # Emacs
    {
      inherit (pkgs)
        sqlite
        editorconfig-core-c
        pywal
        delta
        pandoc;
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
