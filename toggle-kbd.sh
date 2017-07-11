#!/bin/bash


key_id=`xinput list | grep "AT Translated Set 2 keyboard" | grep "=[0-9]\+" -o | grep "[0-9]\+" -o`

if [ "$key_id" ];then
  state=`xinput list-props $key_id | grep "Device Enabled ([0-9]\+)" | grep "[0,1]$" -o`
  if [ "$state" = "1" ]; then
    echo "Internal Keyboard Disabled"
    xinput set-prop $key_id "Device Enabled" 0
  else
    echo "Internal Keyboard Enabled"
    xinput set-prop $key_id "Device Enabled" 1
  fi
fi
