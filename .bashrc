### Bash prompt.
PS1_LAMBDA="\[\033[38;5;173m\]λ\[\033[0;00m\]"
PS1_DIR="\[\033[38;5;26m\]\w\[\033[00m\]"
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
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gpu='git pull'
alias gpr='git pull --rebase'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grbm='git rebase $(git_main_branch)'
alias gst='git status'

# Python aliases.
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias ipy='ipython'
alias mkvenv='python -m venv ./venv'
alias avenv='source ./venv/bin/activate'
alias dvenv='deactivate'


### Environment variables.
export EDITOR=nvim
export OS="$(uname)"

export LESS='-F -Q -M -R -X -i -g -s -x4 -z-2'
export LESS_TERMCAP_md=$'\e[00;34m'    # Bold mode     - blue.
export LESS_TERMCAP_us=$'\e[00;32m'    # Underline     - green.
export LESS_TERMCAP_so=$'\e[00;40;33m' # Standout      - yellow on grey.
export LESS_TERMCAP_me=$'\e[0m'        # End bold      - reset.
export LESS_TERMCAP_ue=$'\e[0m'        # End underline - reset.
export LESS_TERMCAP_se=$'\e[0m'        # End standout  - reset.
export LESSHISTFILE=-
export PAGER=less

export LS_COLORS="no=00:fi=00:di=38;5;111:ln=38;5;81:pi=38;5;43:bd=38;5;212:\
cd=38;5;225:or=30;48;5;202:ow=38;5;75:so=38;5;177:su=36;48;5;63:ex=38;5;156:\
mi=38;5;115:*.exe=38;5;156:*.bat=38;5;156:*.tar=38;5;204:*.tgz=38;5;205:\
*.tbz2=38;5;205:*.zip=38;5;206:*.7z=38;5;206:*.gz=38;5;205:*.bz2=38;5;205:\
*.rar=38;5;205:*.rpm=38;5;173:*.deb=38;5;173:*.dmg=38;5;173:\
*.jpg=38;5;141:*.jpeg=38;5;147:*.png=38;5;147:\
*.mpg=38;5;151:*.mpeg=38;5;151:*.avi=38;5;151:*.mov=38;5;216:*.wmv=38;5;216:\
*.mp4=38;5;217:*.mkv=38;5;216:\
*.flac=38;5;223:*.mp3=38;5;218:*.wav=38;5;213:*.ape=38;5;213:\
*akefile=38;5;176:*.pdf=38;5;253:*.ods=38;5;224:*.odt=38;5;146:\
*.doc=38;5;224:*.xls=38;5;146:*.docx=38;5;224:*.xlsx=38;5;146:\
*.epub=38;5;152:*.mobi=38;5;105:*.m4b=38;5;222:*.conf=38;5;121:\
*.md=38;5;224:*.markdown=38;5;224:*README=38;5;224:*.ico=38;5;140:\
*.iso=38;5;205"
export EXA_COLORS="da=38;5;252:sb=38;5;204:sn=38;5;43:\
uu=38;5;245:un=38;5;241:ur=38;5;223:uw=38;5;223:ux=38;5;223:ue=38;5;223:\
gr=38;5;153:gw=38;5;153:gx=38;5;153:tr=38;5;175:tw=38;5;175:tx=38;5;175:\
gm=38;5;203:ga=38;5;203:xa=38;5;239:*.ts=00"


### Bash settings.
HISTCONTROL=ignoreboth:erasedups # Erase duplicates.
HISTFILESIZE=99999               # Max size of history file.
HISTIGNORE=?:??                  # Ignore one and two letter commands.
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
