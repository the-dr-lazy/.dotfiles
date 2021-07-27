{ config, pkgs, ... }:

{
  imports = [ ./home/config.nix ./home/shell.nix ];

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
    nixpkgs-fmt
    nix-prefetch-git
    niv
    cachix

    # Basic GNU uitls
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
    libtool

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
    m-cli
    git

    # Natural Language
    languagetool
    (aspellWithDicts (ds: with ds; [ en en-science en-computers fa ]))

    # Cryptography
    bitwarden-cli
    openssh
    openssl

    # Tools
    docker
    docker-compose

    # C
    gcc
    llvm

    # Emacs
    sqlite
    editorconfig-core-c

    # Vim
    vim
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
