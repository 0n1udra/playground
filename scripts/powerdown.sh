#!/bin/bash
tmux send-keys -t sess:0.0 'stop' ENTER
tmux send-keys -t sess:0.1 C-c
tmux send-keys -t sess:0.2 'quit' ENTER

tmux send-keys -t sess:0.3 C-c
tmux send-keys -t sess:0.4 C-c

