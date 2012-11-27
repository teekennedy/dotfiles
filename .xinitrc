#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# Arch packages necessary for this to run:
# [xorg-apps group] - xorg-xset xorg-xsetroot xorg-xrdb xorg-xrandr
# [misc] xscreensaver numlockx xcompmgr feh xmonad
# [AUR] shantz-xwinwrap-bzr

# All machine-specific xinit instructions go here:
. ./.xinitrc-details

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

#include fonts such as terminus
xset +fp /usr/share/fonts/local
xset fp rehash

# I like automatic numlock
numlockx
# merge Xresources into urxvt settings
xrdb -merge ~/.Xresources
# throw in some simple compositing
xcompmgr &
xscreensaver -no-splash &

# use a screensaver for our background
xwinwrap -b -fs -sp -fs -nf -ov -- /usr/lib/xscreensaver/klein -root -delay 34513 -view-mode walk -orientation-marks -mode wireframe -appearance solid -colors rainbow -projection-3d orthographic -projection-4d orthographic -walk-speed 1 -root -window-id WID &
# we can alternatively use a wallpaper
# feh --bg-scale ~/pictures/wallpaper.png

exec herbstluftwm
