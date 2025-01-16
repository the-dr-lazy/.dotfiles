{ ... }:

{
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      cleanup = "zap";
    };
    global.brewfile = true;

    taps = [
      "d12frosted/emacs-plus"
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
      "kowainik/tap"
      "the-dr-lazy/tap"
    ];

    # Basic stuff not available on Nix
    brews = [
      "cocoapods"
      "dbus"
      "gcc"
      "gnupg"
      "ios-deploy"
      "libvterm"
      "pinentry-mac"
      "shared-mime-info"
      "trash"
      "watchman"
    ];

    casks = [
      "alacritty"
      "beekeeper-studio"
      "bitwarden"
      "brave-browser"
      "cyberduck"
      "dash"
      "discord"
      "dropbox"
      "folx"
      "font-ibm-plex"
      "font-juliamono"
      "font-overpass"
      "font-victor-mono-nerd-font"
      "fontbase"
      "gitkraken"
      "google-drive"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "languagetool"
      "macfuse"
      "ngrok/ngrok/ngrok"
      "obsidian"
      "onyx"
      "openconnect-gui"
      "orbstack"
      "postico"
      "postman"
      "rstudio"
      "skype"
      "steam"
      "telegram"
      "the-dr-lazy/tap/sketch"
      "the-unarchiver"
      "utm"
      "webtorrent"
      "whatsapp"
      "wireshark"
      "zotero"
      # "maintenance"
    ];

    extraConfig = ''
      brew "libgccjit", args: ["build-from-source"]
      brew "d12frosted/emacs-plus/emacs-plus@29", args: ["with-elrumo1-icon", "with-poll", "with-imagemagick", "with-native-comp"]   
    '';
  };
}
