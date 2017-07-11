#!/bin/bash

cd "/home/vimsucks/.wine/drive_c/Program Files (x86)"
tar cv "World of Warcraft" | pigz -p 10 -k > "/home/vimsucks/Backup/wow-backup-$(date "+%Y%m%d").tar.gz" --fast
