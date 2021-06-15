### Environment variables.
export REALNAME='Tomas Kala'
export NAME="${REALNAME}"
export EMAIL='me@tomaskala.com'
export GIT_COMMITTER_NAME="${REALNAME}"
export GIT_AUTHOR_NAME="${REALNAME}"

export BROWSER='firefox'
export EDITOR='nvim'
export TERMINAL='st'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export INPUTRC="${HOME}/.config/inputrc"
export MBSYNC_CONFIG="${HOME}/.config/mbsync/mbsyncrc"
export NOTMUCH_CONFIG="${HOME}/.config/notmuch/notmuchrc"
export PASSWORD_STORE_DIR="${HOME}/.local/share/password-store"
export WINEPREFIX="${HOME}/.local/share/wineprefixes/default"
export XINITRC="${HOME}/.config/xinitrc"

OS="$(uname)"
export OS
GPG_TTY="$(tty)"
export GPG_TTY

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
