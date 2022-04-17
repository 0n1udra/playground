#!/usr/bin/python3

import os
from extra import lprint

sess_name = 'sess'
ctx = 'water.py'

# Checks if tmux session exists. os.system will return 0 if successful, so if anything else but zero it probably failed.
if os.system(f'tmux ls | grep {sess_name}'):
    lprint(ctx, "INFO: Tmux 'sess' not found. Executing tmux_setup.py")
    if os.system(f'python3 ~/git/playground/scripts/tmux_setup.py starttmux startbots startservers startapps attachtmux'):
        lprint(ctx, "ERROR: Executing tmux_setup.py")
    else: lprint(ctx, "INFO: Finished tmux_setup.py")
