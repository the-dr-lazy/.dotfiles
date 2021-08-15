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
    ];

    # Basic stuff not available on Nix
    brews = [
      "kowainik/tap/summoner-cli"
      "libvterm"
      "pinentry-mac"
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
      "font-victor-mono-nerd-font"
      "fontbase"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "openconnect-gui"
      "openvpn-connect"
      "postico"
      "skype"
      "steam"
      "telegram"
      "the-unarchiver"
      "whatsapp"
      # "android-file-transfer"
      # "secretive"
    ];

    extraConfig = ''
      brew "d12frosted/emacs-plus/emacs-plus@28", args: ["with-ctags", "with-dbus", "with-elrumo1-icon", "with-mailutils", "with-xwidgets"]
    '';
  };
}
