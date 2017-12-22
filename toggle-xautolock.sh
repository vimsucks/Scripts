#!/bin/bash

if [  "$(pidof xautolock)" ]; then
    pkill xautolock &
    notify-send 自动锁定 自动锁定已关闭
else
    nohup xautolock -time 10 -locker ~/Scripts/lock.sh >> /tmp/nohup.log&
    notify-send 自动锁定 自动锁定已开启，十分钟无操作自动锁定
fi
