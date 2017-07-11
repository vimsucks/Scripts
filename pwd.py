#!/usr/bin/env python3
# _*_ coding:utf-8 _*_

import os
path = os.path.abspath(".")
path = path.split("/")[1:]
apath = ""
for i in range(len(path)):
    if i != len(path) - 1:
        apath = apath + "/" + path[i][0]
    else:
        apath = apath + "/" + path[i]
print(apath, end="")
