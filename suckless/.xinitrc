#!/bin/sh

exec refreshresolution &
exec feh --bg-fill "${HOME}/.wallpaper" &
exec amixer set Capture 40% &
exec dunst &
exec slstatus &
exec dwm
