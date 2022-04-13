import os

sess_name = 'sess'

# Checks if tmux session exists.
if os.system(f'tmux ls | grep {sess_name}') != 0:
    os.system(f'python3 ~/git/playground/scripts/tmux_setup.py starttmux startbots startserver startapps attachtmux')
