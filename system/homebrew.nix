{ ... }:

{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global.brewfile = true;
    global.noLock = true;

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
      "kowainik/tap/summoner-cli"
      "libvterm"
      "pinentry-mac"
      "shared-mime-info"
      "dbus"
      "trash"
    ];

    casks = [
      "alacritty"
      "bitwarden"
      "docker"
      "dropbox"
      "eloston-chromium"
      "firefox"
      "folx"
      "font-ibm-plex"
      "font-juliamono"
      "font-overpass"
      "font-victor-mono-nerd-font"
      "fontbase"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "maintenance"
      "openconnect-gui"
      "openvpn-connect"
      "postico"
      "skype"
      "steam"
      "telegram"
      "the-dr-lazy/tap/sketch"
      "the-unarchiver"
      "visual-studio-code"
      "whatsapp"
      # "android-file-transfer"
      # "secretive"
    ];

    extraConfig = ''
      brew "d12frosted/emacs-plus/emacs-plus@28", args: ["with-ctags", "with-dbus", "with-elrumo1-icon", "with-mailutils", "with-xwidgets"]
    '';
  };
}
