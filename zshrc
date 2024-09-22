# Run 'time ZSH_DEBUGRC=1 zsh -i -c exit' to profile zshrc
if [ -n "${ZSH_DEBUGRC+1}" ]; then
      zmodload zsh/zprof
fi

# Autostart tmux, but not if we're in a tiny IDE terminal window
if [[ $TERM_PROGRAM != "vscode" && $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]]; then
    ZSH_TMUX_AUTOSTART=true
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/$HOME/go/bin:$PATH

# Add Homebrew to PATH on Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Export path to root of dotfiles repo
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Fuzzy finder configuration
export FZF_BASE=/usr/local/bin/fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
echo "Creating a zgen save"
    zgen oh-my-zsh

    # Oh-My-Zsh plugins
    zgen oh-my-zsh plugins/fzf
    zgen oh-my-zsh plugins/tmux

    # Custom plugins
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    # Completions
    zgen load zsh-users/zsh-completions src

    # Theme
    zgen load spaceship-prompt/spaceship-prompt spaceship

    # Files
    zgen load $DOTFILES/lib

    # Save all to init script
    zgen save
fi

# Spaceship configuration
SPACESHIP_PROMPT_ORDER=(
  time            # Time stamps section
  dir             # Current directory section
  git             # Git section (git_branch + git_status)
  kubectl_context # Kubectl context section
  char            # Prompt character
)

# Reset zgen on change
ZGEN_RESET_ON_CHANGE=(
  ${HOME}/.zshrc
  ${DOTFILES}/lib/*.zsh
)

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

bindkey '^y' autosuggest-accept

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
