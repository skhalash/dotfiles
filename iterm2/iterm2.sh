#!/bin/zsh

# Install PowerLine fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Install iTerm2
brew update
brew upgrade
brew cask install iterm2

# Specify the preferences directory
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$SCRIPT_PATH/iterm2"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
