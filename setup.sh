#!/bin/sh
set -eu


usage="Usage: $(basename "$0") [OPTIONS]

Options:
  -p  Install private (encrypted) files.
  -n  Install notmuch hooks.
  -h  Show this message and exit."


GLOBIGNORE=".:..:.git:.gitignore"
install_private=false
install_notmuch=false
gpg="gpg"
command -v gpg2 > /dev/null && gpg="gpg2"


install_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile}"

  echo "Installing ${dotfile}"

  mkdir -p -m 700 "$(dirname "${dest}")"
  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}


decrypt_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile%.gpg}"

  if [ ! -e "${dest}" ] || \
      [ -n "$(find -L "${dotfile}" -prune -newer "${dest}")" ]; then
    echo "Decrypting ${dotfile}"
    mkdir -p -m 700 "$(dirname "${dest}")"
    (umask 0177;
    "${gpg}" --quiet -o "${dest}" -d "${dotfile}")
  else
    echo "Skipping ${dotfile}"
  fi
}


install_notmuch_hooks() {
  echo "Installing notmuch hooks"
  mkdir -p -m 700 ~/Mail/.notmuch/hooks

  hook="$(pwd)/.local/hooks/notmuch-pre-new"
  chmod 700 "${hook}"
  ln -fs "${hook}" ~/Mail/.notmuch/hooks/pre-new

  hook="$(pwd)/.local/hooks/notmuch-post-new"
  chmod 700 "${hook}"
  ln -fs "${hook}" ~/Mail/.notmuch/hooks/post-new
}


while getopts "hnp" arg; do
  case "${arg}" in
    h) echo "${usage}"; exit 0 ;;
    n) install_notmuch=true ;;
    p) install_private=true ;;
    *) echo "${usage}"; exit 1 ;;
  esac
done

for dotfiles_source in .*; do
  find "${dotfiles_source}" -type f | sort | while read -r dotfile; do
    if [ "${dotfile}" = "${dotfile##*.gpg}" ]; then
      install_dotfile "${dotfile}"
    elif [ "${install_private}" = true ]; then
      decrypt_dotfile "${dotfile}"
    fi
  done
done

if [ "${install_notmuch}" = true ]; then
  install_notmuch_hooks
fi

chmod 700 ~/.gnupg
chmod -w .config/vlc/vlcrc
