#!/bin/bash

if [ -n "$1" ]; then
		if [ $1 = "on" ]; then
				xrandr --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --rotate normal
		elif [ $1 = "off" ]; then
				xrandr --output eDP1 --off output HDMI1 --off
		elif [ $1 = "dual" ]; then
				xrandr --output eDP1 --mode 1366x768 --pos 112x1080 --output HDMI1 --primary --mode 1920x1080 --pos 0x0
		else
			  echo "Parameter wrong!"
		fi
else
		if (xrandr | grep "HDMI1 connected" > /dev/null); then
				if [ `cat /sys/class/power_supply/AC/online` = "0" ]; then
						xrandr --output eDP1 --auto --output HDMI1 --off
				else
						xrandr --output eDP1 --mode 1366x768 --pos 112x1080 --output HDMI1 --primary --mode 1920x1080 --pos 0x0
				fi
		fi
fi
#transset-df -n i3bar 0.65 > /dev/null
feh --bg-scale ~/Pictures/WallPapers/space.jpg
i3-msg reload > /dev/null
