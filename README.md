# linux-utils
## Description
Various utilities and settings for the Linux system, Fedora in particular.

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


## Software
When doing a fresh installation, the following software should be installed.

### Internet
* firefox
    * cookie autodelete
    * disconnect
    * facebook container
    * firefox multi-account containers
    * https everywhere
    * reddit enhancement suite
    * smart referer
    * ublock origin
* transmission

### Development
* anaconda
    * create a `base` environment, enable it
    * autoflake
* lua
    * luajit
    * love
* git
* neovim
    * [vim-plug](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
* make

### System utilities
* gnome-tweaks
* kitty
* zsh
    * oh-my-zsh
    * [firacode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions)
    * [agnoster theme and powerline fonts](https://github.com/agnoster/agnoster-zsh-theme)
    * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
    * set as the default shell: `chsh -s $(which zsh)`
* enable ssd trimming
* fzf
* ag
* htop
* openvpn
* pass

### Media
* vlc
* mplayer

### Communication
* discord
* telegram


### Settings
* enable ssd trimming
    ```
    systemctl is-enabled fstrim.timer  # Check
    systemctl enable fstrim.timer  # Enable
    systemctl is-enabled fstrim.timer  # Check again
    ```
