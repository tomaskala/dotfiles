# linux-utils
## Description
Various utilities and settings for the Linux system, Fedora in particular.

I have this repository cloned into my `$HOME` directory and the files symlinked to their respective locations. That is,
* `.zshrc` goes to `$HOME/.zshrc`;
* `aliases.zsh` goes to `$HOME/.oh-my-zsh/custom/aliases.zsh`;
* `init.vim` goes to `$HOME/.config/nvim/init.vim`;
* `kitty.conf` goes to `$HOME/.config/kitty/kitty.conf`;
* `user-overrides.js` goes to `$HOME/.mozilla/firefox/<profile-directory>` (see the Configuration/Firefox section below).

In addition, there are some utility scripts.
* `play.sh` -- a simple interface over `mplayer` to allow:
    * playing files after checking their extensions;
    * playing directories recursively;
    * playing files by the number they begin with.


## Software
When doing a fresh installation, the following software should be installed.

### Internet
* Firefox
* Transmission

### Development
* Anaconda
    * create a `base` environment, enable it
    * autoflake
* Lua
    * luajit
    * love
* Git
* Neovim
    * [vim-plug](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
* Make

### System utilities
* gnome-tweaks
* kitty
* zsh
    * oh-my-zsh
    * [firacode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions)
    * [agnoster theme](https://github.com/agnoster/agnoster-zsh-theme) and [powerline fonts](https://github.com/powerline/fonts)
    * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
    * set as the default shell: `chsh -s $(which zsh)`
* fzf
* ag
* htop
* openvpn
* [pass](https://www.password-store.org)
    * [pass-extension-tail](https://github.com/palortoff/pass-extension-tail)
    * The autocompletion is in `.zshrc`. If it does not work, do `rm $HOME/.zcompdump*` and restart zsh using `exec zsh`.

### Media
* VLC
* MPlayer

### Communication
* Discord
* Telegram


## System configuration
* Turn off bluetooth
* Enable SSD trimming
    ```
    systemctl is-enabled fstrim.timer  # Check
    systemctl enable fstrim.timer  # Enable
    systemctl is-enabled fstrim.timer  # Check again
    ```
* Firefox
    * [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
    * Once the `user-overrides.js` file is symlinked to the Firefox profile directory, run the `updater.sh` [script](https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/updater.sh) downloaded from the git repo.
    * After fully configuring Firefox, press `Ctrl+Shift+Del` and clear everything.
* [Hosts file](https://github.com/StevenBlack/hosts/)
    * Unified hosts + fakenews + gambling
* Nautilus
    * Sort directories before files
* SSH key


## Firefox configuration
* Create a new profile
* Remove system addons
    * Either
    ```
    cd /usr/lib/firefox/browser/features
    sudo rm *.xpi
    ```
    or
    ```
    cd /usr/lib64/firefox/browser/features
    sudo rm *.xpi
    ```
    * Note that this must be redone every time Firefox is updated
* Install the following addons (in this order!) along with the specified configurations:
    1. [Canvas blocker](https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/)
        * **General**
            * `Expert mode: enabled`
            * `Block mode: fake`
            * `Faking`
                * `Random number generator: non-persistent`
        * **APIs**
            * `Canvas API`
                * `Protected part of the canvas API: readout`
                * `Protected API features:` all
            * `Audio API`
                * `Protected audio API: enabled`
                * `Protected API features:` all
            * `History API`
                * `Protected API features:` all
            * `Window API`
                * `Protected window API: enabled`
                * `Protected API features:` all
            * `DOMRect API`
                * `Protected DOMRect API: enabled`
                * `Protected API features:` all
        * **Misc**
            * `Block data URL paged: disabled`
    2. [Clear URLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
    3. [CSS Exfil Protection](https://addons.mozilla.org/en-US/firefox/addon/css-exfil-protection/)
    4. [Decentraleyes](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/)
    5. [HTTPS Everywhere](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/)
    6. [Skip Redirect](https://addons.mozilla.org/en-US/firefox/addon/skip-redirect/)
    7. [Facebook Container](https://addons.mozilla.org/en-US/firefox/addon/facebook-container/)
    8. [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/)
    9. [Temporary Containers](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/)
    10. [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
    11. [uMatrix](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
