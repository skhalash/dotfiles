#
# Aliases
#

_exists() {
    command -v $1 > /dev/null 2>&1
}

# Run scripts
alias update="source $DOTFILES/scripts/update"

# Quick jump to dotfiles
alias dotfiles="cd $DOTFILES"

# Quick reload of zsh environment
alias reload="source $HOME/.zshrc"

if _exists lsd; then
    unalias ls
      alias ls='lsd'
        alias lt='lsd --tree'
fi

if _exists bat; then
  alias cat='BAT_THEME="gruvbox-dark" bat --paging=never'
fi
