# suckless tools

## Dependencies

* `$ sudo dnf install libX11-devel libXft-devel libXinerama-devel`


## dwm

* After cloning the repository, download and `git apply` the
  [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/) patch.

```
$ git clone https://git.suckless.org/dwm
$ cd dwm
$ sudo make clean install
```


## st

```
$ git clone https://git.suckless.org/st
$ cd st
$ sudo make clean install
```

* Install the `symbola` font to make `st` work with emoji characters. Needed due
  to the `black` Python formatter printing out a cake symbol when finished.
  * `$ sudo dnf install gdouros-symbola-fonts`
