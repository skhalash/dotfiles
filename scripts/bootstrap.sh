#!/usr/bin/env bash

# Dotfiles and bootstrap installer
# Installs git, clones repository and symlinks dotfiles to your home directory

set -e
trap on_error SIGTERM

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

_exists() {
  command -v "$1" > /dev/null 2>&1
}

# Success reporter
info() {
  echo -e "${CYAN}${*}${RESET}"
}

# Error reporter
error() {
  echo -e "${RED}${*}${RESET}"
}

# Success reporter
success() {
  echo -e "${GREEN}${*}${RESET}"
}

# End section
finish() {
  success "Done!"
  echo
  sleep 1
}

# Set directory
export DOTFILES=${1:-"$HOME/.dotfiles"}
GITHUB_REPO_URL_BASE="https://github.com/skhalash/dotfiles"
HOMEBREW_INSTALLER_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

on_start() {
  info "This script will guide you through installing git, zsh and dofiles itself."
  echo "It will not install anything without your direct agreement!"
  echo
  read -p "Do you want to proceed with installation? [y/N] " -n 1 answer
  echo
  if [ "${answer}" != "y" ]; then
    exit
  fi
}

install_homebrew() {
  info "Trying to detect installed Homebrew..."

  if ! _exists brew; then
    echo "Seems like you don't have Homebrew installed!"
    read -p "Do you agree to proceed with Homebrew installation? [y/N] " -n 1 answer
    echo
    if [ "${answer}" != "y" ]; then
      return
    fi

    info "Installing Homebrew..."
    bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER_URL})"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    success "You already have Homebrew installed. Skipping..."
  fi

  finish
}

install_git() {
  info "Trying to detect installed Git..."

  if ! _exists git; then
    echo "Seems like you don't have Git installed!"
    read -p "Do you agree to proceed with Git installation? [y/N] " -n 1 answer
    echo
    if [ "${answer}" != "y" ]; then
      return
    fi

    info "Installing Git..."

    if [ "$(uname)" = "Darwin" ]; then
      brew install git
    elif [ "$(uname)" = "Linux" ]; then
      sudo apt install git
    else
      error "Error: Failed to install Git!"
      return
    fi
  else
    success "You already have Git installed. Skipping..."
  fi

  finish
}

install_zsh() {
  info "Trying to detect installed Zsh..."

  if ! _exists zsh; then
    echo "Seems like you don't have Zsh installed!"
    read -p "Do you agree to proceed with Zsh installation? [y/N] " -n 1 answer
    echo
    if [ "${answer}" != "y" ]; then
      return
    fi

    info "Installing Zsh..."

    if [ "$(uname)" = "Darwin" ]; then
      brew install zsh zsh-completions
    elif [ "$(uname)" = "Linux" ]; then
      sudo apt install zsh
    else
      error "Error: Failed to install Zsh!"
      return
    fi
  else
    success "You already have Zsh installed. Skipping..."
  fi

  if _exists zsh && [[ -z "$ZSH_VERSION" ]]; then
    info "Setting up Zsh as default shell..."

    echo "The script will ask you the password for sudo:"
    echo
    echo "1) When changing your default shell via chsh -s"
    echo

    chsh -s "$(command -v zsh)" || error "Error: Cannot set Zsh as default shell!"
  fi

  finish
}

install_software() {
  if [ "$(uname)" != "Darwin" ]; then
    return
  fi

  info "Installing software..."

  cd "$DOTFILES"

  # Homebrew Bundle
  if _exists brew; then
    brew bundle
  else
    error "Error: Brew is not available"
  fi

  cd -

  finish
}

on_finish() {
  echo
  success "Setup was successfully done!"
  success "Happy Coding!"
  info "P.S: Don't forget to restart a terminal :)"
  echo
}

on_error() {
  echo
  error "Wow... Something serious happened!"
  error "Though, I don't know what really happened :("
  error "In case, you want to help me fix this problem, raise an issue -> ${CYAN}${GITHUB_REPO_URL_BASE}issues/new${RESET}"
  echo
  exit 1
}

main() {
  on_start "$*"
  install_homebrew "$*"
  install_git "$*"
  install_zsh "$*"
  install_software "$*"
  on_finish "$*"
}

main "$*"
