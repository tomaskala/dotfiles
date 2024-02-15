path=(~/.local/bin $path)

[[ -f ~/.nix-profile/etc/profile.d/nix.sh ]] && source ~/.nix-profile/etc/profile.d/nix.sh
[[ -f "$ZDOTDIR/.zprofile_local" ]] && source "$ZDOTDIR/.zprofile_local"
