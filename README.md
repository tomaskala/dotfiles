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
* [Hosts file](https://github.com/StevenBlack/hosts/)
    * Unified hosts + fakenews + gambling
* Nautilus
    * Sort directories before files
* SSH key


## Firefox configuration
Note that this is a privacy/security oriented configuration. After the initial setting, there will be a period when you have to tweak the addons to your taste so that they do not block websites you visit. For instance, embedded YouTube videos or gifs will not work until you enable them in uMatrix. To do this correctly requires care, otherwise you end up breaking something or losing some degree of privacy.

If in doubt, do not use the uMatrix addon. Along with Skip Redirect, it is expected to cause the most trouble. The other addons should be fairly harmless regarding website breakage.

### Post-installation cleanup
* Create a new profile. Importing data from an old profile is addressed towards the end of this section.
* Remove system addons
    * Either `cd /usr/lib/firefox/browser/features` or `cd /usr/lib64/firefox/browser/features` followed by `sudo rm *.xpi`
    * Note that this must be redone every time Firefox is updated

### Addons
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
3. [CSS Exfil Protection](https://addons.mozilla.org/en-US/firefox/addon/css-exfil-protection/)
4. [Decentraleyes](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/)
    * Enable everything except `Block requests for missing resources`
5. [Smart HTTPS](https://addons.mozilla.org/en-US/firefox/addon/smart-https-revived/)
6. [Skip Redirect](https://addons.mozilla.org/en-US/firefox/addon/skip-redirect/)
7. [Facebook Container](https://addons.mozilla.org/en-US/firefox/addon/facebook-container/)
8. [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/)
    * Create desired containers, visit all matching sites in these containers and check `Always open in this container`
    * Then (if you wish) visit them again and check `Remember my decision` to always open them in the assigned container
9. [Temporary Containers](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/)
    * **General**
        * `Automatic mode: enabled`
    * **Isolation**
        * `Middle Mouse: Different from Tab Domain & Subdomains`
        * `Ctrl/Cmd + Left Mouse: Different from Tab Domain & Subdomains`
10. [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
    * **Settings**
        * `Hide placeholders of blocked elements: enabled`
        * `I am an advanced user: enabled` -> set `suspendTabsUntilReady` to `true` -> `I am an advanced user: disabled`
        * **Privacy**
            * Enable all
        * **Default behavior**
            * `Disable cosmetic filtering: enabled`
    * **Filter lists** -- check the following
        * `Auto-update filter lists`
        * `Parse and enforce cosmetic filters`
        * `Ignore generic cosmetic filters`
        * `My filters`
        * `Built-in:` all except `uBlock filters - Experimental`
        * `Ads`
            * `Adblock Warning Removal List`
            * `EasyList`
        * `Privacy:` all
        * `Malware domains:` all
        * `Annoyances`
            * `AdGuard Annoyances`
            * `Fanboy's Annoyance List`
        * `Multipurpose`
            * `Dan Pollock's hosts file`
            * `Peter Lowe's Ad and tracking server list`
        * `Regions, languages`
            * `CZE, SVK: EasyList Czech and Slovak`
            * `RUS: AdGuard Russian`
            * `RUS: RU AdList`
        * `Custom:` [Import this file for cryptominer blocking](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt)
11. [uMatrix](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
    * Click the toolbar icon and then the title bar to get to the settings dashboard
    * **Settings**
        * **Convenience**
            * `Show the number of blocked resources on the icon: enabled`
            * `Collapse the placeholder of blacklisted elements: enabled`
            * `Spoof <script> tags when 1-st party scripts are blocker`
        * **Privacy**
            * `Delete blocked cookies: enabled`
            * `Delete non-blocked session cookies 60 minutes after the last time they have been used`
            * `Delete local storage content set by blocked hostnames: enabled`
            * `Clear browser cache every 60 minutes`
            * `Spoof HTTP referrer string of third-party requests: enabled`
            * `Block all hyperlink auditing attempts: enabled`
    * **My rules**
        * Add `no-workers: * true`, save and commit (disables web workers)
        * Add [these rules](https://git.synz.io/Synzvato/decentraleyes/wikis/Frequently-Asked-Questions) since Decentraleyes is used as well
    * **Assets**
        * `Auto-update assets: enabled`
        * Disable all hosts files filter lists, purge caches and save (we use uBlock Origin to control the static filters)
        * `Ruleset recipes for English websites: enabled` (a puzzle piece icon will appear on the uMatrix panel allowing to quickly import a community-created ruleset)

### Configuration -- preferences
* This section concerns the `about:preferences` part of the options. Some of it may be overriden by the `user.js` file set below, but there are parts that the file does not address. These are mainly convenience and user interface settings.
* First, click the main menu -> `Customize`. Then, clear the top bar from all the addon icons and mess that Firefox comes with. It should be enough to leave only uMatrix and Firefox Multi-Account Containers.
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
* `Custom settings`
    * `Trackers: enabled, Only in Private Windows`
    * `Cookies: enabled, All third-party cookies`
    * `Cryptominers: enabled`
    * `Fingerprinters: enabled`
* `Send Do Not Track: Always` (oh honey...)

**Logins and Passwords**
* `Ask to save logins and passwords for websites: disabled`

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
* `Block pop-up windows: enabled`
* `Warn you when websites try to install add-ons: enabled`
* `Prevent accessibility services from accessing your browser: enabled` (requires Firefox restart)

**Firefox Data Collection and Use**
* Disable all

**Security**
* Enable all

**Certificates**
* `Ask you every time`

### Configuration -- user.js
* We use [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
* Once the `user-overrides.js` file from this repository is symlinked to the Firefox profile directory, run the `updater.sh` [script](https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/updater.sh) within the same directory.

### Import data
* Consult [this document](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data) where each profile element can be found.
* I transfer *Bookmarks, Downloads and Browsing History* (files `places.sqlite`, `bookmarkbackups` and favicons.sqlite`) and *Stored session* (file `sessionstore.jsonlz4`).


### Cleanup
* Finally, after fully configuring Firefox, press `Ctrl+Shift+Del` and clear everything except `Browsing & Download History`
