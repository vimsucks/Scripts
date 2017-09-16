#!/usr/bin/env python3
import vtools
import webbrowser

vtools.load_config()
resp = vtools.cust.get_login_response()
#webbrowser.open_new_tab(resp.history[-1].url)
webbrowser.get("/usr/bin/google-chrome-stable %s").open_new_tab(resp.history[-1].url)
