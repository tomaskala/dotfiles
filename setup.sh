#!/bin/sh
set -eu

usage="Usage: $(basename "$0") [OPTIONS]

Options:
  -p  Install private (encrypted) files.
  -h  Show this message and exit."

install_private=false
gpg="gpg"
command -v gpg2 > /dev/null && gpg="gpg2"

install_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile}"

  printf 'Installing %s\n' "${dotfile}"
  mkdir -p "$(dirname "${dest}")"

  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}

decrypt_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile%.gpg}"

  if [ ! -e "${dest}" ] || \
      [ -n "$(find -L "${dotfile}" -prune -newer "${dest}")" ]; then
    printf 'Decrypting %s\n' "${dotfile}"
    mkdir -p "$(dirname "${dest}")"

    (umask 0177;
    "${gpg}" --quiet -o "${dest}" -d "${dotfile}")
  else
    printf 'Skipping %s\n' "${dotfile}"
  fi
}

while getopts "hnp" arg; do
  case "${arg}" in
    h) printf '%s\n' "${usage}"; exit 0 ;;
    p) install_private=true ;;
    *) printf '%s\n' "${usage}"; exit 1 ;;
  esac
done

for dotfiles_source in .*; do
  if [ "${dotfiles_source}" = '.' ] \
    || [ "${dotfiles_source}" = '..' ] \
    || [ "${dotfiles_source#.git}" != "${dotfiles_source}" ]; then
    continue
  fi

  find "${dotfiles_source}" -type f | sort | while read -r dotfile; do
    if [ "${dotfile}" = "${dotfile##*.gpg}" ]; then
      install_dotfile "${dotfile}"
    elif [ "${install_private}" = true ]; then
      decrypt_dotfile "${dotfile}"
    fi
  done
done

chmod 700 ~/.gnupg
