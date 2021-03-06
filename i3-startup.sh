#!/bin/bash
auto-randr.sh
log="/tmp/i3-startup.log"

open() {
    nohup $@ >> $log &
}

echo "Startup in progess..."

xrdb -load ~/.Xresources
xset -b
xset dpms 600
unset http_proxy
unset https_proxy
# auto lock screen after 10 minutes of inactivity
#open xautolock -time 10 -locker ~/Scripts/lock.sh
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

#change-wallpaper.sh
#open bing-daily-wallpaper

open fcitx-autostart
open sogou-qimpanel
open nm-applet

pkill dropbox
open dropbox

pkill udiskie
open udiskie

pkill dunst
open dunst -fn \"WenQuanYi Micro Hei\" -conf ~/.dunstrc
#kill `pgrep xfce4-notifyd`
#/usr/lib/xfce4/notifyd/xfce4-notifyd

pkill compton
open compton -b

pkill copyq
open copyq

nohup termite -e "tmux attach" > /tmp/i3-startup.log&
sleep 2 && i3-msg '[instance=termite]move scratchpad' > /tmp/fuck.log

#kill `pgrep conky`
#conky

#pkill `thunderbird`
#thunderbird &
open thunderbird
open google-chrome-stable
#open transmission-gtk
open httphome.py

open transmission-gtk

open emacs --daemon
