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

# Set k9s config path
export K9S_CONFIG_DIR=$HOME/.config/k9s

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
fi

export FZF_DEFAULT_OPTS='-m --height 50%'

# Set FZF Solarized Light color scheme
_gen_fzf_color_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"
  # Uncomment for truecolor, if your terminal supports it.
  # local base03="#002b36"
  # local base02="#073642"
  # local base01="#586e75"
  # local base00="#657b83"
  # local base0="#839496"
  # local base1="#93a1a1"
  # local base2="#eee8d5"
  # local base3="#fdf6e3"
  # local yellow="#b58900"
  # local orange="#cb4b16"
  # local red="#dc322f"
  # local magenta="#d33682"
  # local violet="#6c71c4"
  # local blue="#268bd2"
  # local cyan="#2aa198"
  # local green="#859900"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  # export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  #   --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
  #   --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow"

  ## Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow"
}

_gen_fzf_color_opts

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
