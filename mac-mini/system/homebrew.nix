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
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "kowainik/tap"
      "the-dr-lazy/tap"
    ];

    # Basic stuff not available on Nix
    brews = [
      "cocoapods"
      "dbus"
      "libvterm"
      "shared-mime-info"
      "trash"
      "watchman"
    ];

    casks = [
      "airdroid"
      "alacritty"
      "android-file-transfer"
      "beekeeper-studio"
      "bitwarden"
      "brave-browser"
      "dash"
      "discord"
      "docker"
      "dropbox"
      "expressvpn"
      "folx"
      "font-ibm-plex"
      "font-juliamono"
      "font-overpass"
      "font-victor-mono-nerd-font"
      "fontbase"
      "gitkraken"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "languagetool"
      "macfuse"
      "maintenance"
      "obsidian"
      "openconnect-gui"
      "postico"
      "postman"
      "skype"
      "steam"
      "telegram"
      "the-dr-lazy/tap/sketch"
      "the-unarchiver"
      "webtorrent"
      "whatsapp"
      "zotero"
      "zulu11"
      "utm"
      # "openvpn-connect"
    ];

    extraConfig = ''
      brew "libgccjit", args: ["build-from-source"]
      brew "d12frosted/emacs-plus/emacs-plus@28", args: ["with-elrumo1-icon", "with-no-frame-refocus", "with-xwidgets", "with-imagemagick", "with-native-comp"]
    '';
  };
}
