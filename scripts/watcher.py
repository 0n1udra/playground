#!/usr/bin/python3
import os

sess_name = 'sess'
ctx = 'watcher.py'

# Checks if tmux session exists. os.system will return 0 if successful, so if anything else but zero it probably failed.
if os.system(f'tmux ls | grep {sess_name}'):
    from extra import lprint

    lprint(ctx, "INFO: Tmux 'sess' not found. Executing tmux_setup.py")
    if os.system(f'python3 ~/git/playground/scripts/tmux-setup.py starttmux startbots startapps attachtmux'):
        lprint(ctx, "ERROR: Executing tmux-setup.py")
    else:
        lprint(ctx, "INFO: Finished tmux-setup.py")

        # Tests for internet. Sends message to Discord channel if ping works, else will try for ~4min, 30s sleep.
        import time
        for i in range(8):
            if os.system('ping -c 2 www.google.com'):
                time.sleep(30)
            else:
                os.system(f"python3 ~/git/playground/scripts/matsumoto.py 'Rebooted'")
                lprint(ctx, "Internet restored")
                break


