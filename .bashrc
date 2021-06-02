### Bash prompt.
unset PS1
PS1_LAMBDA="\[\e[38;5;173m\]λ\[\e[0m\]"
PS1_DIR="\[\e[38;5;78m\]\w\[\e[0m\]"
PS1="${PS1_LAMBDA} ${PS1_DIR} "


### Aliases.
unalias -a

# Utilities.
alias ls='ls --color --classify --human-readable --quoting-style=escape'
alias ll='ls -l'
alias lla='ls -la'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias diff='diff --color'

# Media.
alias y='youtube-dl'
alias yp='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'

# Audio control.
alias audio-hdmi='pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo'
alias audio-laptop='pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo'

# Editor aliases.
alias vim='nvim'
alias vi='nvim'

# Git aliases.
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gc='git commit -v'
alias 'gc!'='git commit -v --amend'
alias gcb='git checkout -b'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias glg='git log --stat'
alias gpu='git pull'
alias gpr='git pull --rebase'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(git branch --show-current)'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grs='git restore'
alias gst='git status'


### Bash settings.
HISTCONTROL=ignoreboth:erasedups # Erase duplicates.
HISTFILESIZE=99999               # Max size of history file.
HISTIGNORE="?:??"                # Ignore one and two letter commands.
HISTSIZE=99999                   # Amount of history to save.

# Enable the useful Bash features:
# - cdspell: automatically fix directory typos when changing directory.
# - direxpand: automatically expand directory globs when completing.
# - dirspell: automatically fix directory typos when completing.
# - globstar: ** recursive glob.
# - histappend: append to history, don't overwrite.
# - histverify: expand, but don't automatically execute, history expansions.
# - nocaseglob: case-insensitive globbing.
# - no_empty_cmd_completion: don't TAB expand empty lines.
shopt -s cdspell direxpand dirspell globstar histappend histverify \
  nocaseglob no_empty_cmd_completion


### Additional sources.
function source_if_exists {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

source_if_exists "/usr/share/bash-completion/bash_completion"
source_if_exists "/usr/share/fzf/shell/key-bindings.bash"


### Display a message when opening a terminal.
if [[ -f "./.motd" ]]; then
  cat "./.motd"
fi
