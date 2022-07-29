{ ... }:

{
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
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
      "libvterm"
      "shared-mime-info"
      "dbus"
      "trash"
    ];

    casks = [
      "alacritty"
      "android-file-transfer"
      "beekeeper-studio"
      "bitwarden"
      "blender"
      "discord"
      "docker"
      "dropbox"
      # BROKEN "eloston-chromium"
      "brave-browser"
      "folx"
      "font-ibm-plex"
      "font-juliamono"
      "font-overpass"
      "font-victor-mono-nerd-font"
      "fontbase"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "macfuse"
      "maintenance"
      "expressvpn"
      "openconnect-gui"
      "parallels"
      "postico"
      "postman"
      "skype"
      "steam"
      "telegram"
      "the-dr-lazy/tap/sketch"
      "the-unarchiver"
      "visual-studio-code"
      "whatsapp"
      "exodus"
    ];

    extraConfig = ''
      brew "d12frosted/emacs-plus/emacs-plus@28", args: ["with-ctags", "with-dbus", "with-elrumo1-icon", "with-mailutils", "with-xwidgets"]
    '';
  };
}
