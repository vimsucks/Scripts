#!/bin/bash

sudo systemctl stop dropbox@vimsucks.service
sudo systemctl stop jetbrains-license-server.service
sudo rfkill block bluetooth
pkill nm-applet
#pkill i3blocks
pkill steam
