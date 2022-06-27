#!/usr/bin/python3

import time, sys, os
from extra import lprint

filename = 'tmux_setup.py'
tmux_session_name = 'sess'

def start_tmux_session():
    """Starts Tmux session in detached mode, with 2 panes, and sets name."""

    # Start tmux session
    os.system(f'tmux new -d -s {tmux_session_name}')

    # === Server window
    # Renames window, create 2 bottom panes (3 total for first window)
    os.system(f'tmux rename-window -t {tmux_session_name} Server \
&& tmux split-window -v -t {tmux_session_name}:0.0 \
&& tmux split-window -v -t {tmux_session_name}:0.0 \
&& tmux split-window -v -t {tmux_session_name}:0.2 \
&& tmux split-window -h -t {tmux_session_name}:0.3 \
&& tmux split-window -h -t {tmux_session_name}:0.2 \
&& tmux split-window -h -t {tmux_session_name}:0.1 \
&& tmux split-window -h -t {tmux_session_name}:0.0')

    # === Another window with 2 panes
    os.system(f'tmux new-window -t {tmux_session_name} && \
tmux rename-window -t {tmux_session_name}:1 More')
#tmux split-window -v -t {tmux_session_name}:1.0')

    # Sets tmux powerline theme.
    os.system(f'tmux send-keys -t {tmux_session_name}:1.0 "vim" ENTER && \
tmux send-keys -t {tmux_session_name}:1.0 ":q!" ENTER')

    # === Extra panel
    os.system(f'tmux new-window -t {tmux_session_name} && \
tmux split-window -v -t {tmux_session_name}:2.0')

    time.sleep(1)

if __name__ == '__main__':
    if 'starttmux' in sys.argv:
        start_tmux_session()
        lprint(filename, "INFO: Constructed tmux session")

    if 'startbots' in sys.argv:
        os.system(f'tmux send-keys -t {tmux_session_name}:0.5 "slimebot" ENTER')  # Start slime_server bot
        os.system(f'tmux send-keys -t {tmux_session_name}:0.6 "gogit && cd liquor_bot/source && python liquor_bot.py" ENTER')  # Start channel17 bot
        os.system(f'tmux send-keys -t {tmux_session_name}:0.7 "sandownbot" ENTER')  # Start channel17 bot
        lprint(filename, "INFO: Started bots in tmux session")

    if 'startapps' in sys.argv:
        os.system(f'tmux send-keys -t {tmux_session_name}:1.0 bpytop ENTER')  # Start bpytop

    if 'startservers' in sys.argv:
        os.system(f'tmux send-keys -t {tmux_session_name}:0.0 "srcslime && python3 ~/git/slime_server/source/run_bot.py startserver" ENTER')
        lprint(filename, "INFO: Started servers in tmux session")
