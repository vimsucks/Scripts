#!/bin/bash

if [ -n "$1" ]; then
		if [ $1 = "on" ]; then
				xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left --output DP2 --off
		elif [ $1 = "off" ]; then
				xrandr --output HDMI1 --off
		elif [ $1 = "dual" ]; then
				xrandr --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 1080x1056 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left --output DP2 --off
		else
			  echo "Parameter wrong!"
		fi
else
		if (xrandr | grep "HDMI1 connected" > /dev/null); then
				if [ `cat /sys/class/power_supply/AC/online` = "0" ]; then
						xrandr --output HDMI1 --off
				else
						xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left --output DP2 --off
				fi
		fi
fi
transset-df -n i3bar 0.65 > /dev/null
feh --bg-scale ~/Pictures/WallPapers/vwall.jpg --bg-scale ~/Pictures/WallPapers/flat.jpg
i3-msg reload > /dev/null
