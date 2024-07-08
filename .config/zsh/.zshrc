autoload -Uz colors && colors
bindkey -e
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char
PROMPT="%B%F{magenta}%n@%m%f %F{blue}%~%f %#%b "
RPROMPT="%(0?.%F{green}.%F{red})%?%f [%*]"

setopt autocd
setopt interactive_comments
setopt nomatch
unsetopt beep
unsetopt extendedglob
unsetopt notify

setopt appendhistory
setopt histsavenodups
setopt incappendhistory

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zcompdump"
_comp_options+=(globdots)
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zcompcache" menu select
zmodload zsh/complist

unalias -a

alias vim='nvim'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FNh --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ls -la'
alias ya='mpv --no-video --ytdl-format=bestaudio'

source <(fzf --zsh)
[[ -f "$ZDOTDIR/.zshrc_local" ]] && source "$ZDOTDIR/.zshrc_local"
