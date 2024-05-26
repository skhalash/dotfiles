# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/$HOME/go/bin:$PATH


source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
echo "Creating a zgen save"
    zgen oh-my-zsh

    # Oh-My-Zsh plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found

    # Custom plugins
    zgen load junegunn/fzf
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    # Completions
    zgen load zsh-users/zsh-completions src

    # Theme
    zgen load spaceship-prompt/spaceship-prompt spaceship

    # Save all to init script
    zgen save
fi

# Spaceship configuration
SPACESHIP_PROMPT_ORDER=(
  time            # Time stamps section
  user            # Username section
  dir             # Current directory section
  host            # Hostname section
  git             # Git section (git_branch + git_status)
  kubectl_context # Kubectl context section
  exec_time       # Execution time
  char            # Prompt character
)

# Fuzzy finder configuration
export FZF_BASE=/usr/local/bin/fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

source <(kubectl completion zsh)
autoload -U compinit && compinit

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
