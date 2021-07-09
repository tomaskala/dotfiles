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
  target_dir="$(dirname "${dest}")"

  printf 'Installing %s\n' "${dotfile}"

  mkdir -p "${target_dir}"
  [ "${target_dir}" != "${HOME}" ] && chmod -R 700 "${target_dir}"
  chmod go-rwx "${dotfile}"
  ln -fs "$(pwd)/${dotfile}" "${dest}"
}


decrypt_dotfile() {
  dotfile="$1"
  dest="${HOME}/${dotfile%.gpg}"

  if [ ! -e "${dest}" ] || \
      [ -n "$(find -L "${dotfile}" -prune -newer "${dest}")" ]; then
    printf 'Decrypting %s\n' "${dotfile}"
    target_dir="$(dirname "${dest}")"
    mkdir -p "${target_dir}"
    [ "${target_dir}" != "${HOME}" ] && chmod -R 700 "${target_dir}"
    (umask 0177;
    "${gpg}" --quiet -o "${dest}" -d "${dotfile}")
  else
    printf 'Skipping %s\n' "${dotfile}"
  fi
}


install_notmuch_hooks() {
  printf 'Installing notmuch hooks\n'
  mkdir -p ~/Mail/.notmuch/hooks
  chmod -R 700 ~/Mail/.notmuch/hooks

  hook="$(pwd)/.local/hooks/notmuch-pre-new"
  chmod 700 "${hook}"
  ln -fs "${hook}" ~/Mail/.notmuch/hooks/pre-new

  hook="$(pwd)/.local/hooks/notmuch-post-new"
  chmod 700 "${hook}"
  ln -fs "${hook}" ~/Mail/.notmuch/hooks/post-new
}


while getopts "hnp" arg; do
  case "${arg}" in
    h) printf '%s\n' "${usage}"; exit 0 ;;
    n) install_notmuch=true ;;
    p) install_private=true ;;
    *) printf '%s\n' "${usage}"; exit 1 ;;
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
