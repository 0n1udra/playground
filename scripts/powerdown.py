#!/usr/bin/python3
import time, sys, os
from extra import lprint

reason = 'N/A'
def powerdown(wait_time=40):
    lprint('powerdown.py', f"INFO: System powering down: {reason}")
    # Halts games
    os.system(f"tmux send-keys -t sess:0.0 'stop' ENTER")
    os.system(f"tmux send-keys -t sess:0.1 C-c")
    os.system(f"tmux send-keys -t sess:0.2 'quit' ENTER")
    # Halts bots
    os.system(f"tmux send-keys -t sess:0.5 C-c")
    os.system(f"tmux send-keys -t sess:0.6 C-c")

    # Give 30s before system power off
    time.sleep(wait_time)
    # System power off

if __name__ == '__main__':
    if 'ups' in sys.argv:
        reason = 'CyberPower Trigger'

    powerdown()
    if '--restart' in sys.argv:
        os.system(f"sudo reboot now")
    else: os.system(f"sudo shutdown now")
