set -gx EMAIL me@tomaskala.com
set -gx EDITOR nvim
set -gx SSH_AUTH_SOCK ~/.ssh/agent.sock

set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share

set -gx WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"

set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOBIN ~/.local/bin
set -gx GOTOOLCHAIN local

set -g fish_greeting
fish_add_path ~/.local/bin
fzf --fish | source
