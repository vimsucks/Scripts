#!/bin/bash

cd /tmp
wget -N https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
sed "s/server=\///g; s/\/.*$//g" accelerated-domains.china.conf > ~/.meow/direct
