# Path to your oh-my-zsh installation.
export ZSH="/Users/stak/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kubecontext dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)

plugins=(
  git
  docker
  kubectl
  zsh-completions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
