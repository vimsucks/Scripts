#!/bin/bash
export DISPLAY=:0.0
#export DISPLAY=:1
wallpaper_path="/home/vimsucks/Pictures/pixiv-wallpapers/"
wallpaper_path+=`ls $wallpaper_path| shuf -n 1 2>&1`
feh --bg-scale "$wallpaper_path" > /dev/null
