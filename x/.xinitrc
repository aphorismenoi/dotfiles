#!/bin/sh
#
# ~/.xinitrc
#

# include .Xresources
xrdb ~/.Xresources

# source xinitc.d scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set background
hsetroot -solid '#282828'

# start composite manager 
compton &

# load .Xresources
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp

# add font paths
xset fp default
[[ -d /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local
[[ -d $HOME/.fonts ]] && xset +fp $HOME/.fonts
xset fp rehash

# turn monitor off after 60min
xset s off
xset dpms 3600 3600 3600

# increase mouse acceleration
xset m 3

# Get mouse out of the way 
swarp 0 1440

# start dwm_status
dwm_status 2>&1 >/dev/null &

# start WM
exec $HOME/.scripts/dwm_start 
