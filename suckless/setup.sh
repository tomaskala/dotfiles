#!/bin/sh
set -euf


die() {
  >&2 echo "$1"
  exit 1
}

safeclone() {
  repo="$1"
  dest="$2"

  if [ -d "${dest}" ]; then
    echo "A directory ${dest} already exists. Skipping."
  else
    git clone "${repo}" "${dest}"
  fi
}


if ! type git > /dev/null; then
  die "Git is not installed."
fi

if ! type make > /dev/null; then
  die "Make is not installed."
fi

safeclone "https://git.suckless.org/dwm" "${HOME}/dwm"
ln -fs "$(pwd)/dwm/config.h" "${HOME}/dwm"
sudo make -C "${HOME}/dwm" clean install

safeclone "https://git.suckless.org/st" "${HOME}/st"
ln -fs "$(pwd)/st/config.h" "${HOME}/st"
sudo make -C "${HOME}/st" clean install

ln -fs "$(pwd)/.xinitrc" "${HOME}/.xinitrc"
