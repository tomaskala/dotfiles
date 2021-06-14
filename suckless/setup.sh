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
    echo "The directory ${dest} already exists. Skipping."
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

mkdir -p "${HOME}/suckless"

safeclone "https://git.suckless.org/dwm" "${HOME}/suckless/dwm"
ln -fs "$(pwd)/dwm/config.h" "${HOME}/suckless/dwm"
sudo make -C "${HOME}/suckless/dwm" clean install

safeclone "https://git.suckless.org/dmenu" "${HOME}/suckless/dmenu"
sudo make -C "${HOME}/suckless/dmenu" clean install

safeclone "https://git.suckless.org/slstatus" "${HOME}/suckless/slstatus"
ln -fs "$(pwd)/slstatus/config.h" "${HOME}/suckless/slstatus"
sudo make -C "${HOME}/suckless/slstatus" clean install

safeclone "https://git.suckless.org/st" "${HOME}/suckless/st"
ln -fs "$(pwd)/st/config.h" "${HOME}/suckless/st"
sudo make -C "${HOME}/suckless/st" clean install

safeclone "https://git.suckless.org/slock" "${HOME}/suckless/slock"
sudo make -C "${HOME}/suckless/slock" clean install

ln -fs "$(pwd)/.xprofile" "${HOME}/.config/.xprofile"
ln -fs "$(pwd)/.xinitrc" "${HOME}/.config/.xinitrc"
