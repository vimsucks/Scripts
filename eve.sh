#!/bin/bash

export XIM_PROGRAM=fcitx
export XIM=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
WINEARCH=win32 WINEPREFIX=~/.wine-eve32 wine ~/.wine-eve32/drive_c/EVE/Client/eve.exe
