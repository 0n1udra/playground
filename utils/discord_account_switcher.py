import shutil, time, sys, os


# Set your paths.
discord_roaming = '/mnt/c/Users/DT/AppData/Roaming/discord/Local Storage'
discord_local = '/mnt/c/Users/DT/AppData/Local/Discord'

def stop(): os.system("taskkill.exe /IM Discord.exe /F")
def start(): os.system(f"{discord_local}/Update.exe --processStart Discord.exe")

def backup():
    name = str(input("Save name > "))
    shutil.copytree(f'{discord_roaming}/leveldb/', f'{discord_roaming}/{name}')


def restore():
    stop()
    print(os.listdir(discord_roaming))
    name = str(input("Save name > "))
    if os.path.isdir(f'{discord_roaming}/leveldb'):
        shutil.rmtree(f"{discord_roaming}/leveldb")
    shutil.copytree(f'{discord_roaming}/{name}', f'{discord_roaming}/leveldb')
    time.sleep(1)
    start()

def reset(): 
    stop()
    shutil.rmtree(f"{discord_roaming}/leveldb")
    time.sleep(1)
    start()

if __name__ == '__main__':
    if '-b' in sys.argv: backup()
    if '-r' in sys.argv: restore()
    if '-reset' in sys.argv: reset()



