#!/usr/bin/python3
import time, sys, os
from extra import lprint

filename = 'powerdown.py'
reason = 'N/A'
def powerdown(wait_time=30):
    lprint(filename, f"WARN: Arcpy powering down: {reason}")
    # Halts games
    os.system(f"tmux send-keys -t sess:0.0 'stop' ENTER")
    os.system(f"tmux send-keys -t sess:0.1 C-c")
    os.system(f"tmux send-keys -t sess:0.2 'quit' ENTER")
    # Halts bots
    os.system(f"tmux send-keys -t sess:0.5 C-c")
    os.system(f"tmux send-keys -t sess:0.6 C-c")
    os.system(f"tmux send-keys -t sess:0.7 C-c")

    time.sleep(wait_time)

if __name__ == '__main__':

    if 'ups' in sys.argv:
        reason = 'CyberPower Power failure'

    if 'slime' in sys.argv:
        reason = 'Slime_server command'

    powerdown()
    if '--restart' in sys.argv:
        os.system(f"sudo reboot")
    else: os.system(f"sudo shutdown +1")
