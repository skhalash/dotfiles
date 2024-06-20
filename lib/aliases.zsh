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

# Neovim aliases
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

# Dump dump currently installed vscode extensions to dotfiles
alias vscode-dump="source $DOTFILES/scripts/vscode-extensions-dump"

if _exists lsd; then
    unalias ls
      alias ls='lsd'
        alias lt='lsd --tree'
fi
