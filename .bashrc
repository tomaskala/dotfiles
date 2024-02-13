PS1='\[\e[1;35m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \$ '

GPG_TTY="$(tty)"
export GPG_TTY

unalias -a

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FNh --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ls -la'

alias mvi='mpv --config-dir="${HOME}/.config/mvi"'
alias td='transmission-daemon'
alias tm='transmission-remote'
alias y='yt-dlp'
alias ya='mpv --no-video --ytdl-format=bestaudio'

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=99999
HISTIGNORE='?:??'
HISTSIZE=99999

set -o vi
shopt -s direxpand globstar histappend histverify no_empty_cmd_completion

source /usr/share/fzf/key-bindings.bash
source /usr/share/bash-completion/completions/git

[[ -f "${HOME}/.bashrc_local" ]] && source "${HOME}/.bashrc_local"
