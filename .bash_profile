### Environment variables.
export REALNAME='Tomas Kala'
export EMAIL='me@tomaskala.com'
export GIT_COMMITTER_NAME="${REALNAME}"
export GIT_AUTHOR_NAME="${REALNAME}"

export BROWSER='firefox'
export EDITOR='nvim'
export TERMINAL='st'
export XINITRC="${HOME}/.xinitrc"

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
