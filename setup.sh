#!/usr/bin/env bash
set -eu -o pipefail
GLOBIGNORE=".:..:.git:.gitignore"
INSTALL_PRIVATE=false

GPG="gpg"
which gpg2 &>/dev/null && GPG="gpg2"


__USAGE="Usage: $(basename "$0") [OPTIONS]

Options:
  -p  Install private (encrypted) files.
  -h  Show this message and exit."


function install_dotfile {
  dotfile="$1"
  dest="${HOME}/${dotfile}"

  echo "Installing ${dotfile}"

  mkdir -p -m 700 "$(dirname "${dest}")"
  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}


function decrypt_dotfile {
  dotfile="$1"
  dest="${HOME}/${dotfile%.gpg}"

  if [[ ! -e "${dest}" || "${dotfile}" -nt "${dest}" ]]; then
    echo "Decrypting ${dotfile}"
    mkdir -p -m 700 "$(dirname "${dest}")"
    (umask 0177;
    "${GPG}" --quiet -o "${dest}" -d "${dotfile}")
  else
    echo "Skipping ${dotfile}"
  fi
}


while getopts "hp" arg; do
  case "${arg}" in
    h) echo "${__USAGE}"; exit 0 ;;
    p) INSTALL_PRIVATE=true ;;
    *) echo "${__USAGE}"; exit 1 ;;
  esac
done

for source in .*; do
  while read -r dotfile; do
    if [[ "${dotfile}" = "${dotfile##*.gpg}" ]]; then
      install_dotfile "${dotfile}"
    elif [[ "${INSTALL_PRIVATE}" = true ]]; then
      decrypt_dotfile "${dotfile}"
    fi
  done < <(find "${source}" -type f | sort)
done

chmod 700 ~/.gnupg
chmod -w .config/vlc/vlcrc
