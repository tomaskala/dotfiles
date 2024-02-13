#!/bin/sh
set -eu

install_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile}"

  printf 'Installing %s\n' "${dotfile}"
  mkdir -p "$(dirname "${dest}")"

  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}

for dotfiles_source in .*; do
  if [ "${dotfiles_source}" = '.' ] \
    || [ "${dotfiles_source}" = '..' ] \
    || [ "${dotfiles_source#.git}" != "${dotfiles_source}" ]; then
    continue
  fi

  find "${dotfiles_source}" -type f | sort | while read -r dotfile; do
    install_dotfile "${dotfile}"
  done
done
