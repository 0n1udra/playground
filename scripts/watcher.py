#!/usr/bin/python3
import psutil, time, sys, os
from extra import lprint, dmsg

sess_name = 'sess'
filename = 'watcher.py'

# Tests for internet. Sends message to Discord channel if ping works, else will try for ~4min, 30s sleep.
# Crontab will run this script every 10min
failed_pings = 0
for i in range(8):
    if os.system('ping -c 2 www.google.com'):  # If ping fails
        # If ping fails >3 times it'll restart eno1, if >5, restarts server.
        # This script will start the session up again when ping is successful.
        if failed_pings >= 3:  
            os.system(f'sudo ip link set down eno1 && sleep 5 && sudo ip link set up eno1')
            lprint(filename, "INFO Lost internet. Restarted eno1 interface.")
            dmsg("Restarted eno1")
        if failed_pings >= 5:
            lprint(filename, "INFO: Lost internet. Restarting server.")
            os.system(f'python3 ~/git/playground/scripts/powerdown.py tmux')
            break
        
        failed_pings += 1
        time.sleep(120)
        # 5 pings with 2min sleep, 10min before kill session.

    else:  # If ping success
        # Checks if tmux session exists. os.system will return 0 if successful, so if anything else but zero it probably failed.
        if os.system(f'tmux ls | grep {sess_name}'):
            lprint(filename, "INFO: Tmux 'sess' not found. Executing tmux_setup.py")
            if os.system(f'python3 ~/git/playground/scripts/tmux_setup.py starttmux startbots startservers'):
                lprint(filename, "ERROR: Executing tmux_setup.py")
            else:
                dmsg("Tmux session initiated")
                lprint(filename, "INFO: Finished tmux_setup.py")
        break

def checkbots():
    """
    Checks if python3 bot process are running.
    Sends Discord message of what bots are offline
    """

    discord_bots = {'slime': 'run_bot.py', 'channel17': 'channel17_bot.py'}
    
 #'liquor': 'liquor_bot.py'
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
    if 'lsite' in sys.argv: pass
        #check_liquor_site()

    if 'checkbots' in sys.argv:
        checkbots()
