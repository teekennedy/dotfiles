#!/bin/sh
#
# ~/.xinitrc
#
# All machine-specific xinit instructions go here:
fn=`basename $0`
[ -x $fn-details ] && ./$fn-details

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# use all the same default apps as Xfce does
export DE='xfce'

# for locally installed packages
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# needed for TwinView SDL gaming
export SDL_VIDEO_FULLSCREEN_HEAD=1

# needed for Minecraft
export _JAVA_AWT_WM_NONREPARENTING=1

# needed for Steam
export SDL_AUDIODRIVER=alsa

#include fonts such as terminus
xset +fp /usr/share/fonts/local
xset fp rehash

# set right alt as the compose key
setxkbmap -option compose:ralt

# I like automatic numlock
numlockx
# merge Xresources into urxvt settings
xrdb -merge ~/.Xresources
# throw in some simple compositing
xcompmgr &
xscreensaver -no-splash &

# use a random wallpaper for the background
feh --bg-fill \
    --no-xinerama \
    "$(find ~/pictures/wallpaper -regex ".*\.\(jpg\|jpeg\|png\)" | shuf -n1)"
#set status bar
while true; do
    xsetroot -name "$(date +%R)"
    sleep 50
done &

exec dwm
