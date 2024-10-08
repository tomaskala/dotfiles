# Dotfiles

I use Arch, btw.

## Installation

- Clone this repository.
- Install the necessary software.
- Run the `setup.sh` script which will symlink config files to their respective
  locations.

## Backup

Before reinstalling the system, backup the following:

- Firefox profile: `~/.mozilla/firefox/<profile-directory>`:
  - `places.sqlite`;
  - `bookmarkbackups`;
  - `favicons.sqlite`;
  - `sessionstore.jsonlz4`.
- Downloads directory: `~/Downloads`.
- Pictures directory: `~/Pictures`.
- SSH keys.
  - Export the `~/.ssh` directory.
  - To restore, copy the directory back, `cd` into it, run the ssh agent
    (`eval $(ssh-agent)`) and perform the following (for each private & public
    key pair):
    ```
    $ chmod 600 id_rsa
    $ chmod 644 id_rsa.pub
    $ ssh-add id_rsa
    ```
  - In case the added keys are not persistent and you are required to enter
    the private key password on every `git push`, add `AddKeysToAgent yes` to
    the top of `~/.ssh/config`.

## System setup

### Software

The following software should then be installed.

#### Internet

```
# pacman -S firefox thunderbird
```

#### Development

```
# pacman -S git nvim make ctags
```

#### System utilities

```
# pacman -S dash fish tmux fzf ripgrep htop wget man-db man-pages rsync bc
```
- [shellcheck](https://aur.archlinux.org/packages/shellcheck-bin/)
  - The binary version from AUR is dependency-free.
- Link `dash` to `/bin/sh`.
  ```
  # ln -sfT dash /usr/bin/sh
  ```
- Automatically relink `dash` to `/bin/sh` after every `bash` update. Put the
  following `pacman` hook to `/usr/share/libalpm/hooks/dashbinsh.hook`.
  ```
  [Trigger]
  Type = Package
  Operation = Install
  Operation = Upgrade
  Target = bash

  [Action]
  Description = Re-pointing /bin/sh symlink to dash...
  When = PostTransaction
  Exec = /usr/bin/ln -sfT dash /usr/bin/sh
  Depends = dash
  ```
  
#### Fonts

```
# pacman -S ttf-bitstream-vera noto-fonts noto-fonts-emoji ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono
```

#### Media

```
# pacman -S mpv ffmpeg yt-dlp
```

#### Communication

```
# pacman -S discord
```
- [telegram](https://aur.archlinux.org/packages/telegram-desktop-bin/)

### Firefox configuration

Create a new profile. Importing data from an old profile is addressed towards 
the end of this section.

#### Addons

1. [uBlock
Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
  - Setup a [blocking mode](https://github.com/gorhill/uBlock/wiki/Blocking-mode).
  - Import the following custom lists.
    - [Actually Legitimate URL Shortener 
      Tool](https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt).
    - [NoCoin Adblock 
      List](https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt)
    - [uBlock Origin Dev 
      Filter](https://raw.githubusercontent.com/quenhus/uBlock-Origin-dev-filter/main/dist/all_search_engines/global.txt).
    - [GitHub Less Social](https://git.sr.ht/~toastal/github-less-social) can
      be used to make GitHub look less like a social network.
    - [letsblock.it](https://letsblock.it/) has some nifty filters.
2. [Sponsorblock](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)
   - `Sponsor: Auto Skip`
   - `Interaction Reminder (Subscribe): Auto Skip`
3. [Vimium-FF](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/)
  - Add the following two rules to the blacklist. They are to disable
    vimium-ff in Jupyter notebooks, typically found on such URLs.
    - `https?://localhost*`;
    - `https?://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}*`;
4. [Tree Style
   Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/)
5. [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)

#### Configuration

- Set the following search engines (using bookmarks, since Firefox does not
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
- Go to `about:config` and set 
  `toolkit.legacyUserProfileCustomizations.stylesheets` to `true` to enable 
  `userChrome.css`.
- Symlink `firefox/userChrome.css` to 
  `~/.mozilla/firefox/<profile-directory>/chrome/`

#### Import data

- Consult [this
  document](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data)
  where each profile element can be found.
- I transfer *Bookmarks, Downloads and Browsing History* (files `places.sqlite`,
  `bookmarkbackups` and `favicons.sqlite`) and *Stored session* (file
  `sessionstore.jsonlz4`).

#### Cleanup

- Finally, after having fully configured Firefox, press `Ctrl+Shift+Del` and
  clear everything except `Browsing & Download History`.
