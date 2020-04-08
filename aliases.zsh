alias ll="ls -lh"
alias lla="ls -lah"
alias vim="nvim"
alias vi="nvim"
alias cls="clear"
alias jn="jupyter notebook"
alias jl="jupyter lab"
alias py="python"
alias ipy="ipython"

function cc {
    cd "$1" && ll
}

function upgrade_kitty {
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}
