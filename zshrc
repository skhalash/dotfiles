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
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/$HOME/go/bin:$PATH

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
# Set FZF Catppuccin color scheme
# https://github.com/catppuccin/fzf
_set_fzf_catppuccin_colors() {
      # Detect system appearance mode (dark or light)
      local appearance_mode
      if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        appearance_mode="dark"
      else
        appearance_mode="light"
      fi

      if [[ $appearance_mode == "light" ]]; then
        # Catppuccin Mocha (Dark) color scheme for fzf
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
        --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
        --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
        --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
        --color=selected-bg:#bcc0cc \
        --color=border:#ccd0da,label:#4c4f69"
      else
        # Catppuccin Latte (Light) color scheme for fzf
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --color=selected-bg:#45475a \
        --color=border:#313244,label:#cdd6f4"
     fi
}

_set_fzf_catppuccin_colors

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
