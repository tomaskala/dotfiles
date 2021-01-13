#!/bin/bash

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
set_ln "${root_dir}/.tmux.conf" "$HOME/.tmux.conf"
set_ln "${root_dir}/nvim" "$HOME/.config/nvim"
