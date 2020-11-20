# linux-utils
## Description
Various utilities and settings for the Linux system, Fedora in particular.

I have this repository cloned into my `$HOME` directory and the files symlinked to their respective locations. That is,
* `.zshrc` goes to `$HOME/.zshrc`;
* `aliases.zsh` goes to `$HOME/.oh-my-zsh/custom/aliases.zsh`;
* `nvim` goes to `$HOME/.config/nvim`;
* `kitty.conf` goes to `$HOME/.config/kitty/kitty.conf`;
* `user-overrides.js` goes to `$HOME/.mozilla/firefox/<profile-directory>` (see the Configuration/Firefox section below).


## Backup


Before reinstalling the system, backup the following:
* Firefox profile: `$HOME/.mozilla/firefox/<profile-directory>`:
    * `places.sqlite`
    * `bookmarkbackups`
    * `favicons.sqlite`
    * `sessionstore.jsonlz4`
* Saved passwords: `$HOME/.password-store`
* Downloads directory: `$HOME/Downloads`
* Documents directory: `$HOME/Documents`
* Work directory: `$HOME/Work`
* OpenVPN script: `/etc/openvpn/scripts/update-systemd-resolved`
    * The script addresses some issues encountered when connecting to work VPN. However, it sometimes breaks DNS settings. These must then be restored by executing `sudo nvim /etc/resolv.conf`, replacing the content by `nameserver <dns-server-address>` and restarting the network manager by `sudo service NetworkManager restart`.
    * This file needs executable permissions.
* Export GPG keys.
    * `gpg --armor --export <key-id> > <path-to-backup>/public.key`
    * `gpg --armor --export-secret-keys <key-id> > <path-to-backup>/private.key`
    * `gpg --export-ownertrust > <path-to-backup>/ownertrust.txt`
    * To restore, perform the following:
        * `gpg --import <path-to-backup>/private.key`
        * `gpg --import-ownertrust <path-to-backup>/ownertrust.txt`
* Export SSH keys.
    * Export the `$HOME/.ssh` directory.
    * To restore, copy the directory back and perform the following (for each private & public key pair):
        * `cd $HOME/.ssh`
        * `chown user:user id_rsa*`
        * `chmod 600 id_rsa`
        * `chmod 644 id_rsa.pub`
        * `ssh-add id_rsa`


## System installation


When doing a fresh installation, first update:
* Packages: `sudo dnf distro-sync -y && sync`; the `sync` command synchronized cached writes to persistent storage.
* Firmware: `sudo fwupdmgr refresh && sudo fwupdmgr update --verbose`.
* Flatpaks: `flatpak update && sudo flatpak update`.


### System configuration (not exhaustive)
* Turn off bluetooth.
* Reset the default root password.
* Enable SSD trimming.
    ```
    systemctl is-enabled fstrim.timer  # Check
    systemctl enable fstrim.timer  # Enable
    systemctl is-enabled fstrim.timer  # Check again
    ```
* [Hosts file](https://github.com/StevenBlack/hosts/)
    * Unified hosts + fakenews + gambling.
    * `sudo wget -O '/etc/hosts' 'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts' && sync`
* Nautilus
    * Sort directories before files.
* Fix the retarded `<Alt>Tab` and `<Shift><Alt>Tab` behavior.
    * Install `dconf-editor`, go to `org/gnome/desktop/wm/keybindings`.
    * Move the values from `switch-applications` to `switch-windows`.
    * Move the values from `switch-applications-backward` to `switch-windows-backward`.
* Install `gnome-tweaks` & `No Topleft Hot Corner` to disable the annoying "feature" when activities are opened whenever the cursor hits the top-left corner.
* Set ``<Ctrl>` `` as a keyboard shortcut to launch terminal.
* [Backup LUKS headers](https://fedoraproject.org/wiki/Disk_Encryption_User_Guide#Backup_LUKS_headers).


### Software
The following software should then be installed.

#### Internet
* Firefox
* Thunderbird
    * [Thunderbird and Gmail](https://support.mozilla.org/en-US/kb/thunderbird-and-gmail)
    * [IMAP settings for Gmail](https://support.google.com/mail/answer/78892?hl=en)
* Transmission

#### Development
* [Anaconda](https://www.anaconda.com/distribution/)
    * create a `base` environment, enable it
    * autoflake
    * black
    * flake8
    * mypy
    * disable the annoying environment name prompt: `conda config --set changeps1 false`
* [Lua](https://www.lua.org/)
* Git
* [Neovim](https://neovim.io/)
    * [vim-plug](https://github.com/junegunn/vim-plug)
* Make
* [Intel MKL](https://software.intel.com/content/www/us/en/develop/tools/math-kernel-library/choose-download.html)
* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
* [PyCharm](https://www.jetbrains.com/pycharm/)

#### System utilities
* [kitty](https://sw.kovidgoyal.net/kitty/)
    * Along with the steps specified on the linked page, it is necessary to perform `sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/kitty`.
* zsh
    * [oh-my-zsh](https://ohmyz.sh/)
    * [firacode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions)
    * [agnoster theme](https://github.com/agnoster/agnoster-zsh-theme) and [powerline fonts](https://github.com/powerline/fonts)
    * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
    * set as the default shell: `chsh -s $(which zsh)`
* [fzf](https://github.com/junegunn/fzf)
* [ag](https://github.com/ggreer/the_silver_searcher)
* htop
* sensors
    * `sudo dnf install lm_sensors -y && sudo sensors-detect --auto`
* [pass](https://www.passwordstore.org)
    * [pass-extension-tail](https://github.com/palortoff/pass-extension-tail)
    * The autocompletion is in `.zshrc`. If it does not work, do `rm $HOME/.zcompdump*` and restart zsh using `exec zsh`.

#### Media
* [VLC](https://www.videolan.org/vlc/download-fedora.html)
    * Comes with many codecs necessary to play certain online videos.
    * Rebind `Left/Right` from `Navigate left/right` to `Very short backwards/forward jump`.
* [cmus](https://cmus.github.io/)

#### Communication
* Discord
* Telegram


### Firefox configuration
#### Post-installation cleanup
* Create a new profile. Importing data from an old profile is addressed towards the end of this section.
* Remove system addons
    * Either `cd /usr/lib/firefox/browser/features` or `cd /usr/lib64/firefox/browser/features` followed by `sudo rm *.xpi`
    * Note that this must be redone every time Firefox is updated

#### Addons
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
        * `Block data URL pages: disabled`
2. [Clear URLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
    * `Prevent tracking injection over history API: enabled`
3. [Decentraleyes](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/)
    * Enable everything except `Block requests for missing resources`
4. [Facebook Container](https://addons.mozilla.org/en-US/firefox/addon/facebook-container/)
5. [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/)
    * Create desired containers, visit all matching sites in these containers and check `Always open in this container`
    * Then (if you wish) visit them again and check `Remember my decision` to always open them in the assigned container
6. [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
    * **Settings**
        * `Hide placeholders of blocked elements: enabled`
        * `I am an advanced user: enabled` -> set `suspendTabsUntilReady` to `true` -> `I am an advanced user: disabled`
        * **Privacy**
            * Enable all
        * **Default behavior**
            * `Disable cosmetic filtering: disabled`
    * **Filter lists** -- check the following
        * `Auto-update filter lists`
        * `Parse and enforce cosmetic filters`
        * `My filters`
        * `Built-in`
        * `Ads`
            * `EasyList`
        * `Privacy:`
            * `EasyPrivacy`
            * `Fanboy’s Enhanced Tracking List`
        * `Malware domains:` all
        * `Annoyances`
            * `AdGuard Annoyances`
            * `EasyList Cookie`
            * `Fanboy's Annoyance`
            * `uBlock filters - Annoyances`
        * `Multipurpose`
            * `Dan Pollock's hosts file`
            * `Peter Lowe's Ad and tracking server list`
        * `Regions, languages`
            * `CZE, SVK: EasyList Czech and Slovak`
            * `RUS: RU AdList`
        * `Custom:` [Import this file for cryptominer blocking](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt) -- simply paste the link (not the file contents) to the 'custom' field.
7. [Temporary Containers](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/)
    * **General**
        * `Automatic mode: enabled`
    * **Isolation**
        * `Middle Mouse: Different from Tab Domain & Subdomains`
        * `Ctrl/Cmd + Left Mouse: Different from Tab Domain & Subdomains`
        * `Left Mouse: Different from Tab Domain & Subdomains
8. [Vimium-FF](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/)
    * Add the following two rules to the blacklist. They are to disable vimium-ff in Jupyter notebooks, typically found on such URLs.
        * `http://localhost*`;
        * `https://localhost*`;
        * `http://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}*`;
        * `https://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}*`.

#### Configuration -- preferences
* This section concerns the `about:preferences` part of the options. Some of it may be overriden by the `user.js` file set below, but there are parts that the file does not address. These are mainly convenience and user interface settings.
* First, click the main menu -> `Customize`. Then, clear the top bar from all the addon icons and mess that Firefox comes with. It should be enough to leave only uBlock Origin, uMatrix and Firefox Multi-Account Containers.
* Also select compact mode and dark theme.

1. **General**

**Startup**
* `Restore previous session: enabled`

**Tabs**
* `Ctrl+Tab cycles through tabs in recently used order: disabled`

**Language**
* `Check your spelling as you type: disabled`

**Files and Applications**
* `Always ask you where to save files`

**Browsing**
* `Use autoscrolling: disabled`
* `Use smooth scrolling: enabled`
* `Show a touch keyboard when necessary: disabled`
* `Recommend extensions as you browse: disabled`
* `Recommend features as you browse: disabled`

2. **Home**

**Firefox Home Content**
* Disable all

3. **Search**
* `Default Search Engine: DuckDuckGo`
* `Provide search suggestions: disabled`
* `One-Click Search Engines | Keywords`
    * `DuckDuckGo | d`
    * `Wikipedia (en) | w`
* Optionally add `YouTube | y` and `Metal Archives (band name search) | m`

4. **Privacy & Security**

**Content blocking**
* `Enhanced Tracking protection: Custom`
    * `Cookies: enabled, All third-party cookies`
    * `Tracking content: enabled, In all windows`
    * `Cryptominers: enabled`
    * `Fingerprinters: enabled`
* `Send Do Not Track: Only when Firefox is set to block known trackers`

**Logins and Passwords**
* `Ask to save logins and passwords for websites: disabled`
* `Saved logins` -> `Autofill logins and passwords: disabled`

**History**
* Firefox will `Use custom settings for history`
* `Always use private browsing mode: disabled`
    * `Remember browsing and download history: enabled`
    * `Remember search and form history: disabled`

**Address bar**
* `Browsing history: enabled`
* `Bookmarks: enabled`
* `Open tabs: enabled`

**Permissions**
* `Location: Settings` -> `Block new requests asking to access your location`
* `Camera: Settings` -> `Block new requests asking to access your camera`
* `Autoplay: Settings` -> `Block Audio and Video`
* `Virtual Reality: Settings` -> `Block new requests asking to access your virtual reality devices`
* `Block pop-up windows: enabled`
* `Warn you when websites try to install add-ons: enabled`
    * Clear exceptions
* `Prevent accessibility services from accessing your browser: enabled` (requires Firefox restart)

**Firefox Data Collection and Use**
* Disable all

**Security**
* Enable all

**Certificates**
* `Ask you every time`

**HTTPS-Only Mode**
* `Enable HTTPS-Only Mode in all windows`

#### Configuration -- user.js
* I use [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
* Once the `user-overrides.js` file from this repository is symlinked to the Firefox profile directory, run the `updater.sh` [script](https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/updater.sh) within the same directory.

#### Import data
* Consult [this document](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data) where each profile element can be found.
* I transfer *Bookmarks, Downloads and Browsing History* (files `places.sqlite`, `bookmarkbackups` and `favicons.sqlite`) and *Stored session* (file `sessionstore.jsonlz4`).


#### Cleanup
* Finally, after having fully configured Firefox, press `Ctrl+Shift+Del` and clear everything except `Browsing & Download History`.
