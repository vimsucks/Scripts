#!/bin/bash

state=`fcitx-remote`
if [ $state = 1 ]; then
  notify-send "输入法状态" "Rime"  --urgency=low --category=fcitx
else
  notify-send "输入法状态" "系统键盘" --urgency=low --category=fcitx
fi
fcitx-remote -t
