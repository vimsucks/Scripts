#!/usr/bin/env python2
# _*_ coding:utf-8 _*_

__author__ = 'Chunlin'

import re
import commands
import time
import signal

kbid_pattern = re.compile('(?<=id=)\d+', re.I)
masterid_pattern = re.compile('\d+(?=\)\])', re.I)

IN_KB_ID = -1
IN_MASTER_ID = -1

def signal_handler(signal, frame):
    commands.getoutput('xinput reattach ' + str(IN_KB_ID) + ' ' + str(IN_MASTER_ID))
    print("the process stop safely!")
    exit()

signal.signal(signal.SIGINT, signal_handler)

def getCurrenStatus():
    global IN_KB_ID, IN_MASTER_ID
    # 在此处将 AT Translated 替换成自己系统中内置键盘的特征字符串
    output_in = commands.getoutput('xinput list|grep "AT Translated Set 2 keyboard"')
    # 在此处将 Technology Poker 替换成自己外置键盘的特征字符串
    output_ex = commands.getoutput('xinput list|grep "Topre Corporation HHKB Professional"|tail -n1')
    inOk = re.match('.*slave  keyboard.*', output_in) is not None
    inDis = re.match('.*floating slave.*', output_in) is not None
    exOK = re.match('.*slave  keyboard.*', output_ex) is not None
    exNo = len(output_ex) == 0

    if inOk and exOK:
        # plug in
        s = re.search(kbid_pattern, output_in)
        IN_KB_ID = s.group(0)
        s = re.search(masterid_pattern, output_ex)
        IN_MASTER_ID = s.group(0)
        print('xinput float ' + str(IN_KB_ID))
        commands.getoutput('xinput float ' + str(IN_KB_ID))
        return 1
    elif inOk and exNo:
        # only internal kb
        return 0
    elif inDis and exOK:
        # disabled internal kb
        return 2
    elif inDis and exNo:
        # unplugged external kb
        print('xinput reattach ' + str(IN_KB_ID) + ' ' + str(IN_MASTER_ID))
        commands.getoutput('xinput reattach ' + str(IN_KB_ID) + ' ' + str(IN_MASTER_ID))
        return 3


if __name__ == '__main__':
    while True:
        currentStatus = getCurrenStatus()
        time.sleep(2)
