#! /bin/sh
#
# leetq.sh
# Copyright (C) 2017 vimsucks <dev@vimsucks.com>
#
# Distributed under terms of the MIT license.
#

no=`printf "%03d" $1`
goFile=~/Projects/Go/leetcode-solution/$no-$2.go
orgFile=~/Doc/blog/blog/$no-$2.org
touch $goFile
echo "package main" > $goFile
echo "" >> $goFile
echo "func main() {" >> $goFile
echo "" >> $goFile
echo "}" >> $goFile
touch $orgFile
echo -n "#+TITLE: $no " > $orgFile
words=`echo $2 | tr "-" " "`
for word in ${words[@]}; do
    echo -n " ${word^}" >> $orgFile
done
echo "" >> $orgFile
echo "#+AUTHOR:      Vimsucks
#+EMAIL:       dev@vimsucks.com" >>$orgFile
echo -n "#+Date:        " >> $orgFile
date "+%Y-%m-%d %a" >> $orgFile
echo "#+URI:         /blog/%y/%m/%d/$no-$2" >> $orgFile
echo "#+KEYWORDS:    leetcode
#+TAGS:        leetcode
#+LANGUAGE:    en
#+OPTIONS:     H:3 num:nil toc:nil \n:nil ::t |:t ^:nil -:nil f:t *:t <:t
#+DESCRIPTION: <TODO: insert your description here>" >> $orgFile
echo "" >> $orgFile
echo "* 题目" >> $orgFile
echo "  [[https://leetcode.com/problems/$2/]]" >> $orgFile
echo "" >> $orgFile
echo "* 代码" >> $orgFile
echo "  #+INCLUDE: \"$goFile\" src go" >> $orgFile
