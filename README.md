# Dotfiles


I use Arch, btw.


## Installation

* Clone this repository.
* Install the necessary software.
* Run the `setup.sh` script which will symlink config files to their respective
  locations.
* Once Firefox has been configured, manually symlink the
  `firefox/user-overrides.js` file to `~/.mozilla/firefox/<profile-directory>`.


## Backup

Before reinstalling the system, backup the following:

* Firefox profile: `~/.mozilla/firefox/<profile-directory>`:
  * `places.sqlite`;
  * `bookmarkbackups`;
  * `favicons.sqlite`;
  * `sessionstore.jsonlz4`.
* Saved passwords: `~/.local/share/password-store`.
* Downloads directory: `~/Downloads`.
* Pictures directory: `~/Pictures`.
* Export GPG keys.
  ```
  $ gpg --armor --export-secret-keys <key-id> > <path-to-backup>/private.key
  $ gpg --export-ownertrust > <path-to-backup>/ownertrust.txt
  ```
  * To restore, perform the following:
    ```
    $ gpg --import <path-to-backup>/private.key
    $ gpg --import-ownertrust <path-to-backup>/ownertrust.txt
    ```
* SSH keys.
  * Export the `~/.ssh` directory.
  * To restore, copy the directory back, `cd` into it, run the ssh agent
    (`eval $(ssh-agent)`) and perform the following (for each private & public
    key pair):
    ```
    $ chmod 600 id_rsa
    $ chmod 644 id_rsa.pub
    $ ssh-add id_rsa
    ```
  * In case the added keys are not persistent and you are required to enter
    the private key password on every `git push`, add `AddKeysToAgent yes` to
    the top of `~/.ssh/config`.


## System setup

* Backup LUKS headers.
  ```
  $ sudo cryptsetup luksHeaderBackup --header-backup-file <file> <device>
  ```
* Put the following inside `/etc/X11/xorg.conf.d/90-touchpad.conf` to configure
  the touchpad.
  ```
  Section "InputClass"
      Identifier "touchpad"
      MatchIsTouchpad "on"
      Driver "libinput"
      Option "Tapping" "on"
      Option "NaturalScrolling" "on"
  EndSection
  ```
* Uncomment `Color` in `/etc/pacman.conf`.


### Software

The following software should then be installed.


#### Environment

* pulseaudio
  ```
  $ sudo pacman -S pulseaudio pulseaudio-alsa pamixer
  ```
* X and window manager: see my `suckless` repository.


#### Internet

```
$ sudo pacman -S firefox neomutt isync msmtp lynx
```
* [urlview](https://aur.archlinux.org/packages/urlview/).
  * Delete the `/etc/urlview/` directory, since the default configuration
    defines the `COMMAND` directive, which in turn makes `urlview` not honor
    the `BROWSER` environment variable.
* qutebrowser
  ```
  $ cd
  $ git clone https://github.com/qutebrowser/qutebrowser.git
  $ cd ./qutebrowser
  $ python scripts/mkvenv.py
  $ ln -fs ~/qutebrowser/misc/org.qutebrowser.qutebrowser.desktop ~/.local/share/applications/
  ```
* To synchronize emails for the first time, run the following.
  ```
  $ mkdir -p ~/Mail/"${EMAIL}"
  $ mbsync -a -c "${MBSYNC_CONFIG}"
  ```


#### Development

```
$ sudo pacman -S git neovim make valgrind clang
```
* [vim-plug](https://github.com/junegunn/vim-plug)


#### System utilities

```
$ sudo pacman -S feh xorg-xrandr arandr libnotify dunst maim xclip tmux fzf \
  the_silver_searcher htop pass wget man-db man-pages
```
* [pass bash
  completions](https://git.zx2c4.com/password-store/plain/src/completion/pass.bash-completion),
  put it into `/etc/bash_completion.d/pass`
* [pass-extension-tail](https://github.com/palortoff/pass-extension-tail)
* [pass-update](https://github.com/roddhjav/pass-update)
* [shellcheck](https://aur.archlinux.org/packages/shellcheck-bin/)
  * The binary version from AUR is dependency-free.
* [pmount](https://aur.archlinux.org/packages/pmount/)

  
#### Fonts

```
$ sudo pacman -S ttf-liberation noto-fonts-emoji
```
* [jetbrains mono](https://www.jetbrains.com/lp/mono/).


#### Media

```
$ sudo pacman -S mpv ffmpeg youtube-dl cmus zathura zathura-djvu zathura-ps \
  zathura-pdf-mupdf
```


#### Communication

```
$ sudo pacman -S discord
```
* [telegram](https://aur.archlinux.org/packages/telegram-desktop-bin/)


### Setup unbound

This will setup unbound as the local DNS resolver. For security, unbound is
chrooted into `/etc/unbound`.
```
$ sudo pacman -S unbound expat
$ sudo cp ./etc/unbound/unbound.conf /etc/unbound/unbound.conf
```

Unbound needs access to entropy and to the system log, so they must be bound
inside the chroot. To make the binding persistent, the information needs to be
added to `/etc/fstab`.
```
$ sudo mkdir -p /etc/unbound/dev
$ sudo touch /etc/unbound/dev/random
$ sudo touch /etc/unbound/dev/log
```
Add the following lines to `/etc/fstab`.
```
/dev/random /etc/unbound/dev/random none bind 0 0
/dev/log /etc/unbound/dev/log none bind 0 0
```

Furthermore, to periodically probe the root anchor, the directory
`/etc/unbound` as well as the file `/etc/unbound/trusted-key.key` must be
writable by the `unbound` user.

Next, NetworkManager needs to be configured not to overwrite the DNS server
address with the DHCP-supplied one. Create a
`/etc/NetworkManager/conf.d/dns.conf` file with the following contents.
```
[main]
    dns=none
```
Then, restart NetworkManager and enable and start unbound.
```
$ sudo systemctl restart NetworkManager
$ sudo systemctl enable unbound
$ sudo systemctl start unbound
```

After having set unbound as the local DNS resolver, the boot time got about 2
seconds slower than before. This was not caused by the `/etc/fstab` entries as
suspected, but by having enabled the unbound service. After some investigation,
it turned out that the bottleneck is the NetworkManager-wait-online service
and disabling it fixes the problem.
```
$ sudo systemctl disable NetworkManager-wait-online
```


### Firefox configuration

This section addresses the configuration of the Firefox browser.


#### Post-installation cleanup

* Create a new profile. Importing data from an old profile is addressed towards
  the end of this section.


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
      -- simply paste the link (not the file contents) to the 'custom' field.
  * **My filters**
    ```
    ! https://google.com
    google.com##div:has-text(Before you continue to Google Search)
    google.com##:root:style(overflow: auto !important;)

    ! https://www.google.com
    www.google.com##div:has-text(Before you continue to Google Search)
    www.google.com##:root:style(overflow: auto !important;)
    
    ! stackexchange hot network questions
    ###hot-network-questions
    ```
5. [Vimium-FF](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/)
  * Add the following two rules to the blacklist. They are to disable
    vimium-ff in Jupyter notebooks, typically found on such URLs.
    * `https?://localhost*`;
    * `https?://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}*`;
6. [Tree Style
   Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/)


#### Configuration

* I use [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
* Once the `firefox/user-overrides.js` file from this repository is symlinked to
* the Firefox profile directory, run the `updater.sh`
  [script](https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/updater.sh)
  within the same directory.
* The `firefox/user-overrides.js` file includes most of the `about:preferences`
  contents. The only exception is the **Search engines** section, which must be
  cleared and set to the following (using bookmarks, since Firefox does not
  allow to edit the search engines in preferences).
  ```
  (d) https://duckduckgo.com/?q=%s
  (w) https://en.wikipedia.org/wiki/Special:Search/%s
  (y) https://www.youtube.com/results?search_query=%s
  (r) https://www.reddit.com/search?q=%s
  (gh) https://github.com/search?q=%s
  (http) https://httpstatuses.com/%s
  (m) https://www.metal-archives.com/search?type=band_name&searchString=%s
  (tce) https://www.deepl.com/translator#cs/en/%s
  (tec) https://www.deepl.com/translator#en/cs/%s
  (py) https://docs.python.org/3/search.html?q=%s
  (aw) https://wiki.archlinux.org/index.php?search=%s
  ```
* Install the `firefox/gruvbox.xpi` by opening it (`CTRL+o`) in Firefox.
* Symlink the `firefox/userChrome.css` file to
  `~/.mozilla/firefox/<profile-directory>/chrome`.


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
