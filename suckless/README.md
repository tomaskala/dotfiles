# suckless tools

## Setup

* Install dependencies.
  * `$ sudo dnf install libX11-devel libXft-devel libXinerama-devel`
* Run the `setup.sh` installation script.


## dwm

* After cloning the repository, download and `git apply` the
  [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/) patch.


## st

* Install the `symbola` font to make `st` work with emoji characters. Needed due
  to the `black` Python formatter printing out a cake symbol when finished.
  * `$ sudo dnf install gdouros-symbola-fonts`
