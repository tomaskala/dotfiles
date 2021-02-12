# linux-utils


## My Linux configuration and utilities

I am using the latest Fedora installation.


## Installation

* Clone this repository.
* Install the necessary software.
* Run the `setup.sh` script which will symlink config files to their respective
  locations.
* Once Firefox has been configured, manually symlink the `user-overrides.js`
  file to `~/.mozilla/firefox/<profile-directory>`.


## Backup

Before reinstalling the system, backup the following:
* Firefox profile: `~/.mozilla/firefox/<profile-directory>`:
    * `places.sqlite`;
    * `bookmarkbackups`;
    * `favicons.sqlite`;
    * `sessionstore.jsonlz4`.
* Thunderbird profile: `~/.thunderbird/<profile-directory>`.
* Saved passwords: `~/.password-store`.
* Downloads directory: `~/Downloads`.
* Documents directory: `~/Documents`.
* Pictures directory: `~/Pictures`.
* Work directory: `~/Work`.
* OpenVPN script: `/etc/openvpn/scripts/update-systemd-resolved`.
    * The script addresses some issues encountered when connecting to work VPN.
      However, it sometimes breaks DNS settings. These must then be restored by
      executing `sudo nvim /etc/resolv.conf`, replacing the content by
      `nameserver <dns-server-address>` and restarting the network manager by
      `sudo service NetworkManager restart`.
    * This file needs executable permissions.
* Export GPG keys.
    * `gpg --armor --export-secret-keys <key-id> > <path-to-backup>/private.key`
    * `gpg --export-ownertrust > <path-to-backup>/ownertrust.txt`
    * To restore, perform the following:
        * `gpg --import <path-to-backup>/private.key`
        * `gpg --import-ownertrust <path-to-backup>/ownertrust.txt`
* Export SSH keys.
    * Export the `~/.ssh` directory.
    * To restore, copy the directory back, `cd` into it, run the ssh agent
      (`eval $(ssh-agent)`) and perform the following (for each private & public
      key pair):
        * `chmod 600 id_rsa`
        * `chmod 644 id_rsa.pub`
        * `ssh-add id_rsa`
    * In case the added keys are not persistent and you are required to enter
      the private key password on every `git push`, add `AddKeysToAgent yes` to
      the top of `~/.ssh/config`.


## System installation

* Update packages.
    * `sudo dnf distro-sync -y && sync`
* Update firmware.
    * `sudo fwupdmgr refresh && sudo fwupdmgr update --verbose`
* Enable SSD trimming.
    * `sudo systemctl enable fstrim.timer`
* Download a [hosts file](https://github.com/StevenBlack/hosts/).
    * `sudo wget -O '/etc/hosts'
      'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts'
      && sync`
    * The [hosts](.local/bin/hosts) script can be used here.
* [Backup LUKS
  headers](https://fedoraproject.org/wiki/Disk_Encryption_User_Guide#Backup_LUKS_headers).
* Configure the touchpad on the X Window System.
    * Put the following inside `/etc/X11/xorg.conf.d/90-touchpad.conf`.
      ```
      Section "InputClass"
          Identifier "touchpad"
          MatchIsTouchpad "on"
          Driver "libinput"
          Option "Tapping" "on"
          Option "NaturalScrolling" "on"
      EndSection
      ```


### Software

The following software should then be installed.


#### Internet

* Firefox
* Thunderbird
    * [Thunderbird and
      Gmail](https://support.mozilla.org/en-US/kb/thunderbird-and-gmail)
    * [IMAP settings for
      Gmail](https://support.google.com/mail/answer/78892?hl=en)
    * Install the [No Message Pane
      Sort](https://addons.thunderbird.net/en-US/thunderbird/addon/no-message-pane-sort-by-mouse/)
      addon.
* Transmission


#### Development

* git
    * `sudo dnf install git`
* neovim
    * `sudo dnf install neovim`
    * [vim-plug](https://github.com/junegunn/vim-plug)
* Emacs
    * `sudo dnf install emacs`
    * Note: My configuration requires Emacs >= 27.
* Make
    * `sudo dnf install make`
* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
* [PyCharm](https://www.jetbrains.com/pycharm/)


#### System utilities

* Alacritty
    * `sudo dnf install alacritty`
* Fira Code
    * `sudo dnf install fira-code-fonts`
* bash-completion
    * `sudo dnf install bash-completion`
* tmux
    * `sudo dnf install tmux`
* fzf
    * `sudo dnf install fzf`
* ag
    * `sudo dnf install the_silver_searcher`
* htop
    * `sudo dnf install htop`
* sensors
    * `sudo dnf install lm_sensors -y && sudo sensors-detect --auto`
* [pass](https://www.passwordstore.org)
    * `sudo dnf install pass`
    * Download the [bash completion
      file](https://git.zx2c4.com/password-store/plain/src/completion/pass.bash-completion)
      and put it into `/etc/bash_completion.d` named `pass`.
    * [pass-extension-tail](https://github.com/palortoff/pass-extension-tail)
    * [pass-update](https://github.com/roddhjav/pass-update)
* Virtual Machine Manager
    * `sudo dnf install virt-manager`
* Docker
    * Instead of using `dnf`, follow the [official
      instructions](https://docs.docker.com/engine/install/). The most-recent
      version is needed to get a proper cgroups support.
    * Create the docker group: `sudo groupadd docker`.
    * Add the current user to the group: `sudo usermod -aG docker $USER`.
    * Relog.


#### Media

* [VLC](https://www.videolan.org/vlc/download-fedora.html)
* [cmus](https://cmus.github.io/)


#### Communication

* Discord
* Telegram


### Firefox configuration

This section addresses the configuration of the Firefox browser.


#### Post-installation cleanup

* Create a new profile. Importing data from an old profile is addressed towards
  the end of this section.
* Remove system addons
    * Either `cd /usr/lib/firefox/browser/features` or `cd
      /usr/lib64/firefox/browser/features` followed by `sudo rm *.xpi`
    * Note that this must be redone every time Firefox is updated


#### Addons

1. [Clear URLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
    * `Prevent tracking injection over history API: enabled`
2. [Facebook
Container](https://addons.mozilla.org/en-US/firefox/addon/facebook-container/)
3. [Firefox Multi-Account
Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/)
    * Create the desired containers, visit all matching sites in these
      containers and check `Always open in this container`
    * Then (if you wish) visit them again and check `Remember my decision` to
      always open them in the assigned container
4. [uBlock
Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
    * **Settings**
        * `Hide placeholders of blocked elements: enabled`
        * `I am an advanced user: enabled` -> set `suspendTabsUntilReady` to
          `true` -> `I am an advanced user: disabled`
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
        * `Custom:` [Import this file for cryptominer
          blocking](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt)
          -- simply paste the link (not the file contents) to the 'custom'
          field.
5. [Temporary
Containers](https://addons.mozilla.org/en-US/firefox/addon/temporary-containers/)
    * **General**
        * `Automatic mode: enabled`
    * **Isolation**
        * **Navigation**
            * `Target Domain: Different from Tab Domain & Subdomains`
        * **Mouse Click**
            * `Middle Mouse: Different from Tab Domain & Subdomains`
            * `Ctrl/Cmd + Left Mouse: Different from Tab Domain & Subdomains`
            * `Left Mouse: Different from Tab Domain & Subdomains`
6. [Vimium-FF](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/)
    * Add the following two rules to the blacklist. They are to disable
      vimium-ff in Jupyter notebooks, typically found on such URLs.
        * `https?://localhost*`;
        * `https?://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}*`;


#### Configuration

* I use [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
* Once the `user-overrides.js` file from this repository is symlinked to the
  Firefox profile directory, run the `updater.sh`
  [script](https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/updater.sh)
  within the same directory.
* The `user-overrides.js` file includes most of the `about:preferences` contents.
  The only exception is the **Search engines** section which must be manually
  edited.
  * Select `DuckDuckGo` as the default search engine, remove all engines except
    `DuckDuckGo` and `Wikipedia` and set `d` and `w` as their respective
    keywords.


#### Import data

* Consult [this
  document](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data)
  where each profile element can be found.
* I transfer *Bookmarks, Downloads and Browsing History* (files `places.sqlite`,
  `bookmarkbackups` and `favicons.sqlite`) and *Stored session* (file
  `sessionstore.jsonlz4`).


#### Cleanup

* Finally, after having fully configured Firefox, press `Ctrl+Shift+Del` and
  clear everything except `Browsing & Download History`.
