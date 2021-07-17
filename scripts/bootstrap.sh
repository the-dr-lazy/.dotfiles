#!/usr/bin/env sh

DOTFILES_REPO_URL="https://github.com/the-dr-lazy/.dotfiles"
DOTFILES="$HOME/Projects/github/the-dr-lazy/.dotfiles"

print_step() {
    GREEN='\033[0;32m'
    RESET='\033[0m' # No Color
    printf "\n$GREEN>>> $1$RESET\n\n"
}

if [ -d "$DOTFILES" ]; then 
  printf ">>> The script is not idempotent. Trust me, you don't wanna run it for the second time!\n"
  printf ">>> We're done."
  exit 1
fi

#######################################################
### Nix

print_step "Install Nix."
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume

print_step "Add unstable channel."
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update

print_step "Install home-manager."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install

print_step "Install nix-darwin."
NIX_DARWIN_TEMP_DIR=$(mktemp --directory -t nix-darwin-XXXXX)
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer -o "$NIX_DARWIN_TEMP_DIR/result"

print_step "Clone .dotfiles repo."
git clone "$DOTFILES_REPO_URL" "$DOTFILES"
git submodule update --init
ln -isv "$DOTFILES" "$HOME/.config/nixpkgs"

print_step "Build the 1st home generation."
home-manager switch

print_step "Build the 1st darwin generation."
ln -sv "$DOTFILES/darwin.nix" "$DOTFILES/darwin-configuration.nix"
$NIX_DARWIN_TEMP_DIR/result/bin/darwin-installer
rm -rf "$DOTFILES/darwin-configuration.nix"

#######################################################
### Homebrew

print_step "Let's install Homebrew."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";

print_step "Install Homebrew packages."
brew bundle --file "$DOTFILES/config";

#######################################################
### DOOM Emacs

print_step "Install DOOM Emacs."
ln -sv "$DOTFILES/home/emacs.d" "$HOME/.emacs.d"
$DOTFILES/home/emacs.d/bin/doom install

#######################################################
### Keyboard

print_step "Install keyboard."
ln -sv "$DOTFILES/home/keyboard" "$HOME/.keyboard" 
$DOTFILES/home/keyboard/scripts/setup

#######################################################
### Mac OS X Configuration

print_step "Configure Mac OS X."
$DOTFILES/scripts/macos.sh

#######################################################
### Done

print_step "Everything is setted up, now restart and enjoy your new machine!"
sudo shutdown -r now
