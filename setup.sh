#!/bin/bash
set -eu -o pipefail
GLOBIGNORE=".:..:.git"


function install_dotfile {
  dotfile="$1"
  dest="$HOME/${dotfile}"

  echo "Installing ${dotfile}"

  mkdir -p -m 700 "$(dirname "${dest}")"
  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}


for source in .*; do
  while read -r dotfile; do
    install_dotfile "${dotfile}"
  done < <(find "${source}" -type f | sort)
done


chmod -w .config/vlc/vlcrc
