#!/usr/bin/env python3

import requests
import json
from json.decoder import JSONDecodeError
import os
import shutil
import vtools
import time

URL = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN"
SHARE_DIR = os.path.join(os.environ["HOME"], ".local/share", "bing-daily-wallpaper")
FILE_PATH = os.path.join(SHARE_DIR, "last_update.json")
SESSION = requests.Session()
# SESSION.headers = {
#                 'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36'
#                 }

if not os.path.exists(SHARE_DIR):
    os.mkdir(SHARE_DIR)

def get_this_update():
    resp = SESSION.get(URL)

    this_update = {}
    json_obj = json.loads(resp.text)
    this_update["startdate"] = json_obj["images"][0]["startdate"]
    this_update["url"] = "http://www.bing.com" + json_obj["images"][0]["url"]
    del resp
    return this_update

def get_last_update():
    try:
        with open(FILE_PATH) as f:
            last_update = json.load(f)
            return last_update
    except FileNotFoundError:
        print("Json file not found")
        raise RuntimeError("Failed")
        return None
    except JSONDecodeError:
        print("Json decode Error")
        raise RuntimeError("Failed")
        return None


def write_update_to_file(update):
    with open(FILE_PATH, "w+") as f:
        f.write(json.dumps(update))


def get_update_wallpaper_path(update):
    return os.path.join(SHARE_DIR, update["startdate"]+".jpg")

def download_picture(update):
    url = update["url"]
    resp = SESSION.get(url, stream=True)
    if resp.status_code == 200:
        with open(get_update_wallpaper_path(update), "wb") as f:
            shutil.copyfileobj(resp.raw, f)
        del resp
        return True
    del resp
    return False


def set_background(update):
    os.system("feh --bg-scale " + get_update_wallpaper_path(update))


def check_wallpaper(update):
    return os.path.exists(get_update_wallpaper_path(update))

def main():
    try:
        updated = False

        this_update = get_this_update()
        last_update = get_last_update()
        if last_update is None:
            updated = True
        else:
            if last_update["startdate"] != this_update["startdate"]:
                updated = True

        if updated is True:
            print("Wallpaper updated, downloading newest one")
            downloaded = download_picture(this_update)
            if downloaded and check_wallpaper(this_update):
                print("Download complete")
                write_update_to_file(this_update)
                set_background(this_update)
            else:
                vtools.notify_send("壁纸错误", "下载错误或壁纸文件不存在")
                print("Download error or wallpaper not exists")
        else:
            print("Not updated, using last downloaded one")
            if check_wallpaper(last_update):
                set_background(last_update)
            else:
                vtools.notify_send("壁纸错误", "壁纸文件不存在")
                print("Wallpaper not exists")
        return
    except:
        print("Error occured, fallback to use last updated wallpaper")
        last_wallpaper = os.listdir(SHARE_DIR)[-1]
        os.system("feh --bg-scale " + os.path.join(SHARE_DIR, last_wallpaper))

if __name__ == "__main__":
    main()
