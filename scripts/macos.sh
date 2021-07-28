#!/bin/bash

######################################################
### Precondition

echo "Configuring macOS settings, built-in app, CLI tools, and other Apps"
echo "(press any key to continue, Ctrl-C to abort)"
read -r _

######################################################
### General

# Enable subpixel font rendering on non-Apple LCDs
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults write NSGlobalDomain AppleFontSmoothing -int 2

######################################################
### Network

# Turn Firewall on
m firewall enable

######################################################
### Menu Bar

# Show full clock
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM  HH:mm:ss'
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

######################################################
### Finder

# Expand save panel by default
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSavePrint -bool true
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSavePrint2 -bool true

# Show all files
defaults write com.apple.finder AppleShowAllFiles NO
# Show all filename extensions
m finder showextensions YES
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Show path bar
m finder showpath YES
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

######################################################
### Dock

# Hide the Dock
m dock autohide YES
# Set the icon size of Dock items to 42 pixels
defaults write com.apple.dock tilesize -int 34
# Change dock position to left
m dock position BOTTOM
# Remove all items from Dock
m dock prune
# Animation effect
defaults write com.apple.dock mineffect -string suck
# Magnification
defaults write com.apple.dock magnification -bool TRUE
defaults write com.apple.dock largesize -int 89
# Launchpad
defaults write com.apple.dock springboard-columns -int 8
defaults write com.apple.dock springboard-rows -int 7
defaults write com.apple.dock ResetLaunchPad -bool TRUE

######################################################
### Activity Monitor

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

######################################################
### Safari

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

######################################################
### Done

echo "Configuration finished"
