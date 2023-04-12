export EMAIL='me@tomaskala.com'
export BROWSER=firefox
export EDITOR=vim
export LESS='-F -Q -M -R -X -i -g -s -x4 -z-2'
export LESSHISTFILE=-
export PAGER=less

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export LYNX_CFG="${HOME}/.config/lynx/lynx.cfg"
export INPUTRC="${HOME}/.config/inputrc"
export MBSYNC_CONFIG="${HOME}/.config/mbsync/mbsyncrc"
export PASSWORD_STORE_DIR="${HOME}/.local/share/password-store"
export WINEPREFIX="${HOME}/.local/share/wineprefixes/default"

export GOPATH="${HOME}/.local/share/go"
export GOBIN="${HOME}/.local/share/go/bin"

add() {
  if [[ ":$2:" != *":$1:"* ]]; then
    if [[ -z "$2" ]]; then
      printf '%s' "$1"
    else
      printf '%s' "$1:$2"
    fi
  else
    printf '%s' "$2"
  fi
}

PATH=$(add "${HOME}/.local/bin" "${PATH}")
export PATH
unset -f add

source "${HOME}/.bashrc"
[[ -f "${HOME}/.bash_profile_local" ]] && source "${HOME}/.bash_profile_local"
[[ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]] && source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
