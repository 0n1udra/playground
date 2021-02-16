def start_bot():
    try:
        os.system('source ~/pyenv/minecraft_bot/bin/activate && cd /mnt/c/Users/DT/git/slime_server/source && python run_bot.py starttmux startbot')
    except:
        print("error")

    try:
        os.system('tmux send-keys -t mcserver:1.0 "new-window" ENTER')
        os.system('tmux send-keys -t mcserver:2.0 "split-window -v" ENTER')
    except:
        print("Error")

if __name__ in '__main__':
    start_bot()
