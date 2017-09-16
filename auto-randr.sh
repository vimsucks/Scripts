#!/bin/bash

hdmi_connected=""
power_connected=""
hdmi_changged=false
power_changged=false
if [ -f /sys/class/drm/card0-HDMI-A-1/status ]; then
	if [ "$hdmi_connected" != `cat /sys/class/drm/card0-HDMI-A-1/status 2>&1` ]; then
		hdmi_changged=true
		hdmi_connected=`cat /sys/class/drm/card0-HDMI-A-1/status 2>&1`
	fi
elif [ -f /sys/class/drm/card0-HDMI-A-2/status ]; then
	if [ "$hdmi_connected" != `cat /sys/class/drm/card0-HDMI-A-2/status 2>&1` ]; then
		hdmi_changged=true
		hdmi_connected=`cat /sys/class/drm/card0-HDMI-A-2/status 2>&1`
	fi
elif [ -f /sys/class/drm/card1-HDMI-A-1/status ]; then
	if [ "$hdmi_connected" != `cat /sys/class/drm/card1-HDMI-A-1/status 2>&1` ]; then
		hdmi_changged=true
		hdmi_connected=`cat /sys/class/drm/card1-HDMI-A-1/status 2>&1`
	fi
elif [ -f /sys/class/drm/card1-HDMI-A-2/status ]; then
	if [ "$hdmi_connected" != `cat /sys/class/drm/card1-HDMI-A-2/status 2>&1` ]; then
		hdmi_changged=true
		hdmi_connected=`cat /sys/class/drm/card1-HDMI-A-2/status 2>&1`
	fi
else
	hdmi_changged=false
fi
if [ "$power_connected" != `cat /sys/class/power_supply/AC/online` ]; then
	power_connected=`cat /sys/class/power_supply/AC/online`
	power_changged=true
else
	power_changged=false
fi
if [ $hdmi_changged = true ] || [ $power_changged = true ]; then
	if [ "$hdmi_connected" = "connected" ]; then
		if [ "$power_connected" = "1" ]; then
			#xrandr --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --rotate normal
			lid_status=`cat /proc/acpi/button/lid/LID/state | grep open -o`
			if [ "$lid_status" = "open" ]; then
				if [ "$1" ]; then
					if [ "$1" = "v" ];then
						#xrandr --output eDP1 --mode 1920x1080 --pos 1920x752 --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left
						xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left
					fi
				else
					#xrandr --output eDP1 --mode 1920x1080 --pos 1920x460 --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
					xrandr --output eDP1 --mode 1920x1080 --pos 1920x0 --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
				fi
			else
				if [ "$1" ]; then
					if [ "$1" = "v" ];then
						xrandr --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate left
					fi
				else
					xrandr --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
				fi
			fi
		else
			xrandr --output eDP1 --primary --auto --output HDMI1 --off
		fi
	else
		xrandr --output eDP1 --primary --auto --output HDMI1 --off
	fi
	#if [ "$1" ]; then
		#if [ "$1" = "v" ];then
			# feh --bg-scale ~/Pictures/WallPapers/vertical.jpg 2>&1
			#/home/vimsucks/Scripts/change-wallpaper.sh 2>&1
		#fi
	#else
		#feh --bg-scale ~/Pictures/WallPapers/tml.png 2>&1
		#/home/vimsucks/Scripts/change-wallpaper.sh 2>&1
	#fi
    #feh --bg-scale ~/Pictures/How-to-Learn-Emacs-v2-Large.png
	i3-msg restart
	hdmi_changged=false
	power_changged=false
fi
