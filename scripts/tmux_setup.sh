#!/bin/bash

session="sess"
tmux new -d -s $session
tmux rename-window -t $session
tmux split-window -v -t $session:0.0
tmux split-window -h -t $session:0.0
tmux split-window -h -t $session:0.2

tmux new-window -t $session
tmux rename-window -t $session:1 More
#tmux split-window -v -t {tmux_$sessionion_name}:1.0')

tmux send-keys -t $session:1.0 "vim" ENTER
tmux send-keys -t $session:1.0 ":q!" ENTER


tmux send-keys -t $session:0.1 "slimebot" ENTER
tmux send-keys -t $session:0.3 "sandownbot" ENTER

tmux send-keys -t $session:1.0 bpytop ENTER

tmux send-keys -t $session:0.0 "srcslime && python3 ~/git/slime_server/source/run_bot.py startserver" ENTER
