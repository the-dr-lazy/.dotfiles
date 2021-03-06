#!/bin/bash

DOTFILES_REPO_URL="https://github.com/the-dr-lazy/.dotfiles"
DOTFILES="$HOME/Projects/github/the-dr-lazy/.dotfiles"
CWD=$(pwd)

print_step() {
  GREEN='\033[0;32m'
  RESET='\033[0m' # No Color
  printf "%s>>>>>> %s%s\n" "$GREEN" "$1" "$RESET"
}

initialize_submodule() {
  cd "$DOTFILES"
  git submodule update --init "$1"
  cd "$CWD"
}

#######################################################
### Precondition

print_step "Check prior run."
if [ -d "$DOTFILES" ]; then
  printf "Error: The script is not idempotent. Trust me, you don't wanna run it for the second time!\n" >&2
  printf "<<<<<< We're done." >&2
  exit 1
fi

print_step "Check command line tools installation."
CLT_CHECK=$( (xcode-select --install) 2>&1 )
CLT_OUTPUT="xcode-select: note: install requested for command line developer tools"
if [ "$CLT_CHECK" == "$CLT_OUTPUT" ]; then
  print_step "Command line tools installation has been requested."
  print_step "Waiting until installation complete..."
fi
while [[ "$CLT_CHECK" == "$CLT_OUTPUT" ]]; do
  sleep 10
  CLT_CHECK=$( (xcode-select --install) 2>&1 )
done

print_step "Please make sure you are not on the f*** Iran's internet network!"
print_step "Press <Enter> to continue..."
read -r _

set -e

#######################################################
### Nix

# FIXME: use Nix flakes

print_step "Install Nix."
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
# shellcheck disable=SC1091
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

print_step "Add Nix registry"
nix registry add me github:the-dr-lazy/.dotfiles

print_step "Add unstable channel."
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update

print_step "Install Home Manager."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
rm -rf "$HOME/.config/nixpkgs/home.nix"

print_step "Install Nix Darwin."
NIX_DARWIN_TEMP_DIR=$(mktemp -d -t nix-darwin-XXXXX)
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer -o "$NIX_DARWIN_TEMP_DIR/result"

print_step "Clone .dotfiles repo."
git clone "$DOTFILES_REPO_URL" "$DOTFILES"

#######################################################
### SSH
###

print_step "Initialize ssh submodule."
initialize_submodule "home/ssh"

print_step "Make ~/.ssh symlink."
ln -isv "$DOTFILES/home/ssh" "$HOME/.ssh"
sudo chmod -R 400 "$HOME/.ssh"
sudo chmod u+rwx "$HOME/.ssh"
sudo chmod u+rw "$HOME/.ssh/config"
sudo chmod u+rw "$HOME/.ssh/known_hosts"

print_step "Make ~/.nixpkgs symlink."
ln -isv "$DOTFILES" "$HOME/.nixpkgs"

# print_step "Build the 1st Home generation."
# home-manager switch

print_step "Build the 1st Darwin generation."
ln -sv "$DOTFILES/system.nix" "$DOTFILES/darwin-configuration.nix"
"$NIX_DARWIN_TEMP_DIR/result/bin/darwin-installer"
rm -rf "$DOTFILES/darwin-configuration.nix"
darwin-rebuild switch --flake "$DOTFILES"

print_step "Make fish the default shell."
echo "$HOME/.nix-profile/bin/fish" | sudo tee -a /etc/shells
chsh -s "$HOME/.nix-profile/bin/fish"

#######################################################
### GnuPG
###

print_step "Initialize gnupg submodule."
initialize_submodule "home/gnupg"

print_step "Make ~/.gnupg symlink."
ln -isv "$DOTFILES/home/gnupg" "$HOME/.gnupg"

#######################################################
### DOOM Emacs
###

print_step "Initialize emacs.d submodule."
initialize_submodule "home/emacs.d"

print_step "Make ~/.emacs.d symlink."
ln -isv "$DOTFILES/home/emacs.d" "$HOME/.emacs.d"

print_step "Install DOOM Emacs."
"$DOTFILES"/home/emacs.d/bin/doom install

#######################################################
### Keyboard

print_step "Initialize keyboard submodule."
initialize_submodule "home/keyboard"

print_step "Make ~/.keyboard symlink."
ln -isv "$DOTFILES/home/keyboard" "$HOME/.keyboard"

print_step "Install keyboard."
cd "$DOTFILES/home/keyboard"
"$DOTFILES/home/keyboard/script/setup"
cd "$CWD"

#######################################################
### Mac OS X Configuration

print_step "Configure Mac OS X."
"$DOTFILES"/scripts/macos.sh

#######################################################
### Done

print_step "Everything is setted up, now restart and enjoy your new machine!"
sudo shutdown -r now
