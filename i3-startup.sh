#!/bin/bash
xrdb -load ~/.Xresources
xset -b
xset dpms 600
# xmodmap ~/.Xmodmap && xcape -e '#134=Meta_R' -t 250
# xmodmap ~/.Xmodmap
# disable touchpad click or scrolling while typing
syndaemon -i 1 -t -K -R -d
#feh --bg-scale ~/Pictures/How-to-Learn-Emacs-v2-Large.png

# if hhkb is connected, disable internal keyboard
hhkb_connected=`xinput list | grep HHKB`
if [ -n "$hhkb_connected" ]; then
  xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0
fi


open() {
    nohup $@ >> /tmp/i3-startup.log&
}

auto-randr.sh
change-wallpaper.sh

open fcitx-autostart
open sogou-qimpanel
open nm-applet

dropbox_pid=`pgrep dropbox`
if [ "$dropbox_pid" ]; then
	kill dropbox_pid
fi
open dropbox

kill `pgrep clipmenud`
open clipmenud

kill `pgrep udiskie`
open udiskie

kill `pgrep dunst`
open dunst -fn \"WenQuanYi Micro Hei\" -conf ~/.dunstrc
#kill `pgrep xfce4-notifyd`
#/usr/lib/xfce4/notifyd/xfce4-notifyd

kill "`pgrep compton`"
open "compton -b"

#kill `pgrep conky`
#conky

#pkill `thunderbird`
#thunderbird &

[[ -z "`pgrep emacs`" ]] && emacs --daemon
