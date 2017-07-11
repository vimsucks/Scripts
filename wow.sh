#!/bin/bash

#xrandr --setprovideroffloadsink 0x51 0x7b
#export MESA_GL_VERSION_OVERRIDE=3.3COMPAT
#DRI_PRIME=1 wine "/home/vimsucks/.wine/drive_c/Program Files (x86)/World of Warcraft/Wow.exe"
DRI_PRIME=1 WINEDEBUG=-all __GL_THREADED_OPTIMIZATIONS=1 wine "/home/vimsucks/.wine/drive_c/Program Files (x86)/World of Warcraft/Wow.exe"
