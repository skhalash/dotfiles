#!/bin/zsh

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Updating Homebrew"
    brew update
fi

brew upgrade
brew bundle
