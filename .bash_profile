#!/bin/sh


### Environment variables.
export REALNAME='Tomas Kala'
export EMAIL='me@tomaskala.com'
export GIT_COMMITTER_NAME="${REALNAME}"
export GIT_AUTHOR_NAME="${REALNAME}"
export BROWSER='firefox'
export TERMINAL='st'
export EDITOR='nvim'
OS="$(uname)"
export OS
GPG_TTY="$(tty)"
export GPG_TTY
export LESS='-F -Q -M -R -X -i -g -s -x4 -z-2'
export LESSHISTFILE=-
export PAGER=less


### Path manipulation.
add() {
  if ! echo ":$2:" | grep -q ".*:$1:.*"; then
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
. ~/.bashrc
