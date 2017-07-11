#!/usr/bin/env python3
# _*_ coding:utf-8 _*_

import re
import os
import sys


if os.getuid() != 0:
    print("Please run this script in root!")
    sys.exit(1)
match = []
pattern = "163|.cn"
with open("/etc/pacman.d/mirrorlist") as fileRead:
    for eachLine in fileRead:
        if re.search(pattern, eachLine):
            if eachLine[0] == "#":
                match.append(eachLine[1:])
            else:
                match.append(eachLine)
for eachLine in match:
    print(eachLine, end="")
with open("/etc/pacman.d/mirrorlist", "w") as fileWrite:
    for eachLine in match:
        fileWrite.write(eachLine)
print("Modify successfully!")
