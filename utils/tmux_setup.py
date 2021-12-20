import time, sys, os

tmux_session_name = 'sess2'

def start_tmux_session():
    """Starts Tmux session in detached mode, with 2 panes, and sets name."""

    # Start tmux session
    os.system(f'tmux new -d -s {tmux_session_name}')

    # === Server window
    # Renames window, create 2 bottom panes (3 total for first window)
    os.system(f'tmux rename-window -t {tmux_session_name} Server && tmux split-window -v -t {tmux_session_name}:0.0 && tmux split-window -h -t {tmux_session_name}:0.1')

    # === SSH window
    # New window, renames window, new vertical pane
    os.system(f'tmux new-window -t {tmux_session_name} && tmux rename-window -t {tmux_session_name}:1 SSH && tmux split-window -v -t {tmux_session_name}:1.0')

    # === bash window
    os.system(f'tmux new-window -t {tmux_session_name} && tmux rename-window -t {tmux_session_name}:2 Stuff && tmux split-window -v -t {tmux_session_name}:2.0')

    # === Monitor window
    os.system(f'tmux new-window -t {tmux_session_name} && tmux rename-window -t {tmux_session_name}:3 btop')

    os.system(f'tmux send-keys -t {tmux_session_name}:2.0 "vim" ENTER && tmux send-keys -t {tmux_session_name}:2.0 ":q!" ENTER')  # Sets tmux powerline theme.

    time.sleep(1)

if __name__ == '__main__':
    if 'starttmux' in sys.argv: start_tmux_session()
    if 'startbots' in sys.argv:
        os.system(f'tmux send-keys -t {tmux_session_name}:0.1 "slimebot" ENTER')  # Start slime_server bot
        os.system(f'tmux send-keys -t {tmux_session_name}:0.2 "sandownbot" ENTER')  # Start channel17 bot
    if 'startapp' in sys.argv:
        os.system(f'tmux send-keys -t {tmux_session_name}:1.0 "ssh mbp13" ENTER')  # SSH MBP13
        os.system(f'tmux send-keys -t {tmux_session_name}:3.0 "btop" ENTER')  # Start bpytop
    if 'attachtmux' in sys.argv: os.system(f"tmux attach -t {tmux_session_name}")
