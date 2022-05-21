#!/usr/bin/python3

import time, sys, os
from extra import lprint

ctx = 'tmux_setup.py'

tmux_session_name = 'sess'

def start_tmux_session():
    """Starts Tmux session in detached mode, with 2 panes, and sets name."""

    # Start tmux session
    if os.system(f'tmux new -d -s {tmux_session_name}'):
        lprint(ctx, 'ERROR: Starting tmux session.')

    # === Server window
    # Renames window, create 2 bottom panes (3 total for first window)
    if os.system(f'tmux rename-window -t {tmux_session_name} Server \
&& tmux split-window -v -t {tmux_session_name}:0.0 \
&& tmux split-window -v -t {tmux_session_name}:0.0 \
&& tmux split-window -v -t {tmux_session_name}:0.2 \
&& tmux split-window -h -t {tmux_session_name}:0.3 \
&& tmux split-window -h -t {tmux_session_name}:0.2 \
&& tmux split-window -h -t {tmux_session_name}:0.1'):
        lprint(ctx, 'ERROR: Creating panes in window 0.')

    # === Another window with 2 panes
    if os.system(f'tmux new-window -t {tmux_session_name} && \
tmux rename-window -t {tmux_session_name}:1 More'):
#tmux split-window -v -t {tmux_session_name}:1.0')
        lprint(ctx, 'ERROR: Creating second window.')

    # Sets tmux powerline theme.
    if os.system(f'tmux send-keys -t {tmux_session_name}:1.0 "vim" ENTER && \
tmux send-keys -t {tmux_session_name}:1.0 ":q!" ENTER'):
        lprint(ctx, 'ERROR: Setting tmux theme in sess:1.0.')

    # === Extra panel
    if os.system(f'tmux new-window -t {tmux_session_name} && \
tmux split-window -v -t {tmux_session_name}:2.0'):
        lprint(ctx, 'ERROR: Creating third window.')


    time.sleep(1)

if __name__ == '__main__':
    if 'starttmux' in sys.argv:
        start_tmux_session()

    if 'startbots' in sys.argv:
        if os.system(f'tmux send-keys -t {tmux_session_name}:0.5 "slimebot" ENTER'):  # Start slime_server bot
            lprint(ctx, "ERROR: Executing 'slimebot' in sess:0.5.")
        if os.system(f'tmux send-keys -t {tmux_session_name}:0.6 "sandownbot" ENTER'):  # Start channel17 bot
            lprint(ctx, "ERROR: Executing 'sandownbot' in sess:0.6.")

    if 'startapps' in sys.argv:
        if os.system(f'tmux send-keys -t {tmux_session_name}:1.0 bpytop ENTER'):  # Start bpytop
            lprint(ctx, "ERROR: Opening bpytop in sess:1.0.")

    if 'startservers' in sys.argv:
        if os.system(f'tmux send-keys -t {tmux_session_name}:0.0 "srcslime && python3 ~/git/slime_server/source/run_bot.py startserver" ENTER'):
            lprint(ctx, "ERROR: Executing run_bot.py in sess:0.0.")
