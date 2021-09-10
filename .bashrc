### Bash prompt.
unset PS1
PS1_LAMBDA="\[\e[38;5;173m\]λ\[\e[0m\]"
PS1_DIR="\[\e[38;5;78m\]\w\[\e[0m\]"
PS1="${PS1_LAMBDA} ${PS1_DIR} "


### Aliases.
unalias -a

# Utilities.
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FNh --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ls -la'

# Media.
alias y='youtube-dl'
alias yp='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"'
alias ya='mpv --no-video --ytdl-format=bestaudio'

# Audio control.
alias audio-hdmi='pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo'
alias audio-laptop='pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo'

# Editor aliases.
alias vim='nvim'
alias vimdiff='nvim -d'


### Bash settings.
HISTCONTROL=ignoreboth:erasedups # Erase duplicates.
HISTFILESIZE=99999               # Max size of history file.
HISTIGNORE="?:??"                # Ignore one and two letter commands.
HISTSIZE=99999                   # Amount of history to save.

# Enable the following bash features.
# - vi: enable vi mode.
# - direxpand: automatically expand directory globs when completing.
# - globstar: ** recursive glob.
# - histappend: append to history, don't overwrite.
# - histverify: expand, but don't automatically execute, history expansions.
# - no_empty_cmd_completion: don't TAB expand empty lines.
set -o vi
shopt -s direxpand globstar histappend histverify no_empty_cmd_completion


### Additional sources.
include() {
  [ -r "$1" ] && source "$1"
}

include /usr/share/fzf/key-bindings.bash
include /usr/share/bash-completion/completions/git
include /etc/bash_completion.d/pass
include /etc/bash_completion.d/pass-tail


### Display a message when opening a terminal.
[ -r ~/.motd ] && cat ~/.motd


### Load local configuration (last to allow overrides).
include ~/.bash_local


### Clear the utility functions.
unset -f include
