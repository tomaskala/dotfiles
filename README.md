# linux-utils
Utilities I use to simplify my life in the Linux system.

I have this repository cloned into my `~/` directory and the files symlinked to their respective locations. That is,
* `.zshrc` goes to `~/.zshrc`;
* `aliases.zsh` goes to `~/.oh-my-zsh/custom/aliases.zsh`;
* `init.vim` goes to `~/.config/nvim/init.vim`;
* `kitty.conf` goes to `~/.config/kitty/kitty.conf`.

In addition, there are some utility scripts.
* `play.sh` -- a simple interface over `mplayer` to allow:
    * playing files after checking their extensions;
    * playing directories recursively;
    * playing files by the number they begin with.
