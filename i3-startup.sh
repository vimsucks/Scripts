#!/bin/bash
xrdb -load ~/.Xresources
xset -b
xset dpms 600
# xmodmap ~/.Xmodmap && xcape -e '#134=Meta_R' -t 250
# xmodmap ~/.Xmodmap
# disable touchpad click or scrolling while typing
syndaemon -i 1 -t -K -R -d

# if hhkb is connected, disable internal keyboard
hhkb_connected=`xinput list | grep HHKB`
if [ -n "$hhkb_connected" ]; then
  xinput set-prop "AT Translated Set 2 keyboard" "Device Enabled" 0
fi

auto-randr.sh &

fcitx-autostart & 2>&1
sogou-qimpanel & 2>&1
nm-applet & 2>&1

dropbox_pid=`pgrep dropbox`
if [ "$dropbox_pid" ]; then
	kill dropbox_pid
fi
dropbox & 2>&1

kill `pgrep clipmenud`
clipmenud & 2>&1

kill `pgrep udiskie`
udiskie & 2>&1

kill `pgrep dunst`
dunst -fn "WenQuanYi Micro Hei" -conf ~/.dunstrc & 2>&1

kill "`pgrep compton`"
compton -b

#kill `pgrep conky`
#conky

pkill `thunderbird`
thunderbird &
