#!/bin/sh
set -euf


die() {
  printf '%s\n' "$1" >&2
  exit 1
}

safeclone() {
  repo="$1"
  dest="$2"

  if [ -d "${dest}" ]; then
    printf 'The directory %s already exists. Skipping.\n' "${dest}"
  else
    git clone "${repo}" "${dest}"
  fi
}


if ! command -v git > /dev/null; then
  die "Git is not installed."
fi

if ! command -v make > /dev/null; then
  die "Make is not installed."
fi

mkdir -p ~/suckless

safeclone "https://git.suckless.org/dwm" ~/suckless/dwm
ln -fs "$(pwd)/dwm/config.h" ~/suckless/dwm
sudo make -C ~/suckless/dwm clean install

safeclone "https://git.suckless.org/dmenu" ~/suckless/dmenu
ln -fs "$(pwd)/dmenu/config.h" ~/suckless/dmenu
sudo make -C ~/suckless/dmenu clean install

safeclone "https://git.suckless.org/slstatus" ~/suckless/slstatus
ln -fs "$(pwd)/slstatus/config.h" ~/suckless/slstatus
sudo make -C ~/suckless/slstatus clean install

safeclone "https://git.suckless.org/st" ~/suckless/st
ln -fs "$(pwd)/st/config.h" ~/suckless/st
sudo make -C ~/suckless/st clean install

safeclone "https://git.suckless.org/slock" ~/suckless/slock
sudo make -C ~/suckless/slock clean install

ln -fs "$(pwd)/xprofile" ~/.config/xprofile
ln -fs "$(pwd)/xinitrc" ~/.config/xinitrc
