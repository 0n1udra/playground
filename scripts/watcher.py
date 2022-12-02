#!/usr/bin/python3
import psutil, time, sys, os
from extra import lprint

sess_name = 'sess'
filename = 'watcher.py'

# Tests for internet. Sends message to Discord channel if ping works, else will try for ~4min, 30s sleep.
for i in range(8):
    if os.system('ping -c 2 1.1.1.1'): time.sleep(30)
    else:
        # Checks if tmux session exists. os.system will return 0 if successful, so if anything else but zero it probably failed.
        if os.system(f'tmux ls | grep {sess_name}'):
            lprint(filename, "INFO: Tmux 'sess' not found. Executing tmux_setup.py")
            if os.system(f'python3 ~/git/playground/scripts/tmux_setup.py starttmux startbots'):
                os.system(f"python3 ~/git/playground/scripts/matsumoto.py 'Arcpy: Tmux session initiated'")
                lprint(filename, "ERROR: Executing tmux_setup.py")
            else: lprint(filename, "INFO: Finished tmux_setup.py")
        break

def checkbots():
    """
    Checks if python3 bot process are running.
    Sends Discord message of what bots are offline
    """

    # , 'liquor': 'liquor_bot.py'
    discord_bots = {'slime': 'run_bot.py', 'channel17': 'channel17_bot.py'}
    for proc in psutil.process_iter():
        for k, v in discord_bots.items():
            if v in proc.cmdline() and 'watcher.py' not in proc.cmdline():
                discord_bots[k] = ''

    # Create new list from dictionary only if a value exist.
    offline_bots = ', '.join([k for k, v in discord_bots.items() if v])
    if offline_bots: os.system(f"python3 ~/git/playground/scripts/matsumoto.py **Bots Offline:** {offline_bots}")

def check_liquor_site():
    # Checks liquor_site status, if offline sends Discord message.
    if not os.system('curl -Is https://arcpy.asuscomm.com | grep OK'):
        with open('lsite_status', 'w+') as f: f.write('online')
    else:
        x = ''
        # So script doesn't keep sending Discord message if still offline
        with open('lsite_status', 'r') as f: x = f.read()
        if 'offline' not in x:
            lprint(filename, 'WARN: Liquor site unreachable.')
            os.system("python3 ~/git/playground/scripts/matsumoto.py Liquor site unreachable")
            with open('lsite_status', 'w') as f: f.write('offline')


if __name__ == '__main__':
    if 'lsite' in sys.argv:
        check_liquor_site()

    if 'checkbots' in sys.argv:
        checkbots()
