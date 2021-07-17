{ config, pkgs, ... }:

{
  imports = [ 
    ./home/shell.nix
    ./home/emacs.nix
    ./home/git.nix
    ./home/sqitch.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "the-dr-lazy";
  home.homeDirectory = "/Users/the-dr-lazy";

  # Set nixpkgs options (for home-manager installed packages only).
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };

  # Documentation!
  programs.man.enable = true;
  programs.info.enable = true;

  home.packages = with pkgs; [
    # Nix
    # nix
    nixfmt
    # cacert
    nix-prefetch-git

    # Basic GNU uitls
    coreutils
    findutils
    diffutils
    binutils
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

    # CLI
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

    # Natural Language
    languagetool
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.fa

    # Cryptography
    bitwarden-cli
    openssh
    openssl

    # Tools
    docker
    docker-compose

    # LSP & Formatters
    shellcheck
    dhall-lsp-server
    vale
    pgformatter
    shfmt
    hadolint

    # C
    llvm

    # Emacs
    sqlite
    editorconfig-core-c

    # Vim
    vim

    # Dhall
    dhall
    dhall-nix
    dhall-json

    # Haskell
    (pkgs.haskell.lib.justStaticExecutables haskellPackages.ghcup)
    cabal2nix
    hlint
    stylish-haskell
    (pkgs.haskell.lib.justStaticExecutables haskellPackages.ghcid)

    # JavaScript
    nodejs-16_x

    # Python
    python3Full
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
