import os
def start_bot():
    os.system("mcbot")
    os.system("cd /")
    os.system('cd /mnt/c/Users/DT/git/slime_server/source')
        #os.system('source ~/pyenv/minecraft_bot/bin/activate && cd /mnt/c/Users/DT/git/slime_server/source && python run_bot.py starttmux startbot')
def test():
    try:
        os.system('tmux send-keys -t mcserver:1.0 "tmux new-window" ENTER')
        os.system('tmux send-keys -t mcserver:2.0 "tmux split-window -v" ENTER')
    except:
        print("Error")

start_bot()
