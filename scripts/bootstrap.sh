#!/usr/bin/env sh

DOTFILES_REPO_URL="https://github.com/the-dr-lazy/.dotfiles"
DOTFILES="${HOME}/Projects/github/the-dr-lazy/.dotfiles"

print_step() {
    GREEN='\033[0;32m'
    RESET='\033[0m' # No Color
    printf "\n${GREEN}>>> ${1}${RESET}\n\n"
}

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

print_step "Clone .dotfiles repo."
while [ -d "${DOTFILES}" ]; do
    read -p "Do you wish to remove \"$DOTFILES?\"" yn
    case $yn in
        [Yy]* ) rm -rvf "${DOTFILES}";;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
git clone "${DOTFILES_REPO_URL}" "${DOTFILES}"
ln -isv "${DOTFILES}" "${HOME}/.config/nixpkgs"

print_step "Install home-manager config"
home-manager switch

#######################################################
### Homebrew

print_step "Let's install Homebrew."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";

print_step "Install apps from Homebrew."
brew bundle --file "${DOTFILES}/config";

#######################################################
### Keyboard

sh "${DOTFILES}/home/keyboard/scripts/setup"

#######################################################
### Mac OS X Configuration

print_step "Configure Mac OS X."
sh "${DOTFILES}/scripts/macos.sh";

#######################################################
### Done

print_step "Everything is setted up, now restart and enjoy your new machine!"
sudo shutdown -r now
