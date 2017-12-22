#!/bin/bash

hdmi1_connected=`xrandr | grep "HDMI1 connected"`
power_connected=`cat /sys/class/power_supply/AC/online`
lid_status=`cat /proc/acpi/button/lid/LID/state | grep open -o`
if [ -n "$hdmi1_connected" ]; then
    echo "HDMI1 connected"
else
    echo "HDMI1 disconnected"
fi

if [ $power_connected -eq 1 ]; then
    echo "AC power connected"
else
    echo "AC power disconnected"
fi

if [ "$lid_status" == "open" ]; then
    echo "Laptop lid is open"
else
    echo "Laptop lid is close"
fi

if [ -n "$hdmi1_connected" ] && [ $power_connected -eq 1 ]; then
    echo "Both HDMI1 and AC power are connected, lighting up HDMI1"
    # if lid is close, only light up HDMI1
    if [ "$lid_status" == "open" ]; then
        xrandr --output eDP1 --mode 1920x1080 --right-of HDMI1 --output HDMI1 --primary --mode 1920x1080
    else
        # else light up both
        xrandr --output eDP1 --off --output HDMI1 --primary --mode 1920x1080
    fi
else
    xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --off
fi
