#! /bin/sh
#
# kill-unnecessary.sh
# Copyright (C) 2017 vimsucks <dev@vimsucks.com>
#
# Distributed under terms of the MIT license.
#

pkill rslsync
pkill dropbox
pkill udiskie
pkill copyq
pkill nm-applet
sudo systemctl stop docker
