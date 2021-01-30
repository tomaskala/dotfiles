#!/bin/bash
set -euf -o pipefail


function set_ln {
  what="$1"
  where="$2"

  if [ -f "$where" ]; then
    rm "$where"
  elif [ -d "$where" ]; then
    rm -r "$where"
  fi

  ln -s "$what" "$where"
}

root_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

set_ln "${root_dir}/.bashrc" "$HOME/.bashrc"
set_ln "${root_dir}/.gitconfig" "$HOME/.gitconfig"
set_ln "${root_dir}/.tmux.conf" "$HOME/.tmux.conf"
set_ln "${root_dir}/.config/nvim" "$HOME/.config/nvim"
set_ln "${root_dir}/.wallpaper" "$HOME/.wallpaper"

mkdir -p "$HOME/.fonts"
set_ln "${root_dir}/.fonts/fontawesome.ttf" "$HOME/.fonts/fontawesome.ttf"

mkdir -p "$HOME/.local/bin"

while read -r script; do
  script_name=$(basename "${script}")
  set_ln "${root_dir}/bin/${script_name}" "$HOME/.local/bin/${script_name}"
done < <(find "${root_dir}/bin" -type f -executable)
