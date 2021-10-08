### Environment variables.
export REALNAME='Tomas Kala'
export EMAIL='me@tomaskala.com'
export NAME="${REALNAME}"
export GIT_COMMITTER_NAME="${REALNAME}"
export GIT_AUTHOR_NAME="${REALNAME}"

export BROWSER='firefox'
export EDITOR='nvim'
export TERMINAL='st'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export LYNX_CFG="${HOME}/.config/lynx/lynx.cfg"
export INPUTRC="${HOME}/.config/inputrc"
export MBSYNC_CONFIG="${HOME}/.config/mbsync/mbsyncrc"
export PASSWORD_STORE_DIR="${HOME}/.local/share/password-store"
export VIMINIT='let $MYVIMRC="$HOME/.config/vim/vimrc" | source $MYVIMRC'
export WINEPREFIX="${HOME}/.local/share/wineprefixes/default"
export XINITRC="${HOME}/.config/xinitrc"

export GOPATH="${HOME}/.local/share/go"
export GOBIN="${HOME}/.local/share/go/bin"

OS="$(uname)"
export OS

export LESS='-F -Q -M -R -X -i -g -s -x4 -z-2'
export LESSHISTFILE=-
export PAGER=less


### Path manipulation.
add() {
  if [[ ":$2:" != *":$1:"* ]]; then
    if [ -z "$2" ]; then
      printf '%s' "$1"
    else
      printf '%s' "$1:$2"
    fi
  else
    printf '%s' "$2"
  fi
}

PATH=$(add "${HOME}/.local/bin" "${PATH}")
export PATH


### Source .bashrc in case it does not happen automatically.
source "${HOME}/.bashrc"


### Start the X server on the user's tty if not already running.
if [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg > /dev/null; then
  exec startx "${XINITRC}"
fi


### Clear the utility functions.
unset -f add
