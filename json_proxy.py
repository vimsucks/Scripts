#!/usr/bin/env python
# _*_ coding:utf-8 _*_

import requests
import random
import os
import sys
print(sys.path)
import json
import threading
from bs4 import BeautifulSoup


headers = {
    'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6',
}

valid_proxies = []
proxies = []
count = 0
valid = 0

jsonPath = os.path.expanduser("~") + "/" + ".valid_proxy.json"
picklePath = os.path.expanduser("~") + "/.valid_proxy.txt"

def get_proxy(url, ip_index=0, port_index=1, check_tds=lambda x: True):
    html = requests.get(url, headers=headers).text
    trs = BeautifulSoup(html, "html.parser").findAll("tr")[1:]
    for tr in trs:
        tds = tr.findAll("td")
        if(check_tds(tds)):
            proxies.append("http://" + tds[ip_index].text + ":" + tds[port_index].text)
    if len(trs) > 0:
        print(url + " acquired")

def get_all_proxy():
    get_proxy("http://www.xicidaili.com/nn/", 1, 2, lambda tds: tds[6].find("div", {"class" : "bar_inner fast"}))
    get_proxy("http://www.xicidaili.com/nt/", 1, 2, lambda tds: tds[6].find("div", {"class" : "bar_inner fast"}))
    # get_proxy("http://ip84.com/dlgn-http")
    get_proxy("http://www.mimiip.com/gngao/", check_tds=lambda tds: tds[5].find("div", {"class" : "delay fast_color"}))
    get_proxy("http://www.mimiip.com/gnpu/", check_tds=lambda tds: tds[5].find("div", {"class" : "delay fast_color"}))
    get_proxy("http://www.mimiip.com/gntou/", check_tds=lambda tds: tds[5].find("div", {"class" : "delay fast_color"}))
    get_proxy("http://www.ip3366.net/free/?stype=1", check_tds=lambda tds: tds[5].text[0] <= "2")
    get_proxy("http://www.ip3366.net/free/?stype=2", check_tds=lambda tds: tds[5].text[0] <= "2")
    get_proxy("http://www.kuaidaili.com/free/inha/", check_tds=lambda tds: tds[5].text[0] <= "2")
    get_proxy("http://www.kuaidaili.com/free/intr/", check_tds=lambda tds: tds[5].text[0] <= "2")

def read_exists():
    if (os.path.exists(jsonPath)):
        file = open(jsonPath, "r")
        lst = json.loads(json.dumps(file.read()))
        proxies.extend(lst)
        file.close()

def get_valid_proxy_list():
    global proxies
    get_all_proxy()
    read_exists()
    proxies = list(set(proxies))
    for proxy in proxies:
        threading.Thread(target=test_validation, args=(proxy,)).start()
    return valid_proxies

def get_random_proxy():
    proxies = get_valid_proxy_list()
    index = random.randint(0, len(proxies) - 1)
    return proxies[index]

def test_validation(proxy):
    global count, valid
    try:
        pro = {"http": proxy}
        requests.get("http://baidu.com", headers=headers, timeout=4, proxies = pro)
        print(str(proxy) + " valid")
        valid_proxies.append(proxy)
        valid = valid + 1
    except:
        pass
    if count == len(proxies) - 1:
        dump_files()
    else:
        count = count + 1

def dump_files():
    jsonFile = open(jsonPath, "w")
    jsonFile.write(json.dumps(valid_proxies))
    jsonFile.close()
    print("dump proxy list complete, valid %d, file writed to $HOME/.valid_proxy.json" % (valid))

if __name__ == "__main__":
    get_valid_proxy_list()
