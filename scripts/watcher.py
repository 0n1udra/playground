#!/usr/bin/python3
import requests, time, os
from extra import lprint

sess_name = 'sess'
filename = 'watcher.py'

# Checks if tmux session exists. os.system will return 0 if successful, so if anything else but zero it probably failed.
if os.system(f'tmux ls | grep {sess_name}'):

    lprint(filename, "INFO: Tmux 'sess' not found. Executing tmux_setup.py")
    if os.system(f'python3 ~/git/playground/scripts/tmux_setup.py starttmux startbots startapps attachtmux'):
        lprint(filename, "ERROR: Executing tmux_setup.py")
    else:
        lprint(filename, "INFO: Finished tmux_setup.py")

        # Tests for internet. Sends message to Discord channel if ping works, else will try for ~4min, 30s sleep.
        for i in range(8):
            if os.system('ping -c 2 1.1.1.1'):
                time.sleep(30)
            else:
                os.system(f"python3 ~/git/playground/scripts/matsumoto.py 'Arcpy: Rebooted'")
                lprint(filename, "INFO: Internet restored")
                break

# Checks liquor_site status, if offline sends Discord message.
response = requests.get('http://arcpy.asuscomm.com')
if response.ok:
    with open('lsite_status', 'w+') as f: f.write('online')
else:
    x = ''
    # So script doesn't keep sending Discord message if still offline
    with open('lsite_status', 'r') as f: x = f.read()
    if 'offline' not in x:
        lprint(filename, 'WARN: Liquor site unreachable.')
        os.system("python3 ~/git/playground/scripts/matsumoto.py Liquor site unreachable")
        with open('lsite_status', 'w') as f: f.write('offline')

