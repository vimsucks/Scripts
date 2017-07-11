#!/bin/bash

dt=`date +%Y%m%d`

cd /home/vimsucks/Dropbox/dotfiles
git add -A
git commit -m "${dt}-auto commit"
git push origin master

cd /home/vimsucks/Dropbox/Scripts
git add -A
git commit -m "${dt}-auto commit"
git push origin master

echo "${date} git sync complete"
