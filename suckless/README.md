# suckless tools

## Setup

* Install dependencies.
  * `$ sudo dnf install libX11-devel libXft-devel libXinerama-devel
      libXrandr-devel`
* Run the `setup.sh` installation script.


## dwm

* After cloning the repository, download and `git apply` the
  [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/) and the
  [focusonclick](https://dwm.suckless.org/patches/focusonclick/) patches.


## dmenu

* After cloning the repository, download and `git apply` the
  [case-insensitive](https://tools.suckless.org/dmenu/patches/case-insensitive/)
  patch.


## st

* Install the `symbola` font to make `st` work with emoji characters. Needed due
  to the `black` Python formatter printing out a cake symbol when finished.
  * `$ sudo dnf install gdouros-symbola-fonts`


## slock

* If your system does not define the `nobody` user or the `nogroup` group,
  change the respective values of the `user` and `group` variables in the config
  file to the dummy user and/or group defined by your system.
* Put the following into the `/etc/X11/xorg.conf` file or inside the
    `/etc/X11/xorg.conf.d/` directory to make sure a locked screen cannot be
    bypassed by switching VTs or killing the X server.
  ```
  Section "ServerFlags"
          Option "DontVTSwitch" "True"
          Option "DontZap"      "True"
  EndSection
  ```
