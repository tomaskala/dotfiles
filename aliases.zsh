alias ll="ls -lh"
alias lla="ls -lah"
alias vim="nvim"
alias vi="nvim"
alias cls="clear"
alias upgrade-kitty="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"

function cc {
    cd "$1" && ll
}
