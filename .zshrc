# Basic config
# ----------------------------------------
export PATH="$HOME/.local/bin:$PATH"

export ZSH="/home/tomas/.oh-my-zsh"

ZSH_THEME="agnoster"

# User case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
#
# Command execution timestamp shown in the history.
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
  last-working-dir
  pass
)

# Load oh-my-zsh
# ----------------------------------------
source $ZSH/oh-my-zsh.sh

# Load custom functions
# ----------------------------------------
source ./user-functions.sh

# User configuration
# ----------------------------------------

autoload -Uz compinit
compinit

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Remove hostname.
prompt_context() {}

# CTRL+Space to accept the current suggestion.
bindkey '^ ' autosuggest-accept

# Append conda to the path variable. If this stops working for some
# reason, try `/home/tomas/anaconda3/bin/conda init`.
export PATH="/home/tomas/anaconda3/bin:$PATH"
