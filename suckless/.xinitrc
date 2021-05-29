#!/bin/sh

exec refreshresolution &
exec amixer set Capture 40% &
exec dunst &
exec slstatus &
exec dwm
