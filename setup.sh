#!/bin/bash

function set_ln {
    what="$1"
    where="$2"

    if [ -f "$where" ]
    then
        rm "$where"
    fi

    ln -s "$what" "$where"
}

root_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

set_ln "${root_dir}/.zshrc" "$HOME/.zshrc"
set_ln "${root_dir}/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
set_ln "${root_dir}/custom.zsh-theme" "$HOME/.oh-my-zsh/themes/custom.zsh-theme"
set_ln "${root_dir}/kitty.conf" "$HOME/.config/kitty/kitty.conf"
set_ln "${root_dir}/.bashrc" "$HOME/.bashrc"
set_ln "${root_dir}/.tmux.conf" "$HOME/.tmux.conf"
set_ln "${root_dir}/nvim" "$HOME/.config/nvim"
