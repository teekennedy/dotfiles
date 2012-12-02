#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# use all the same default apps as Xfce does
export DE='xfce'

#include fonts such as terminus
xset +fp /usr/share/fonts/local
xset fp rehash

start_xmonad()
{
	# merge Xresources into urxvt settings
	xrdb -merge ~/.Xresources
	# throw in some simple compositing
	xcompmgr &
	trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 14 &
	xsetroot -cursor_name left_ptr
	feh --bg-scale ~/pictures/wallpaper.png
	xmonad
}

start_xfce()
{
	exec startxfce4
}

DEFAULT_SESSION=start_xmonad
case $1 in
xmonad)
	start_xmonad
	;;
xfce4)
	start_xfce
	;;
*)
	$DEFAULT_SESSION
	;;
esac
