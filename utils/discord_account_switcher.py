import shutil, time, sys, os

# Set your paths.
discord_roaming = '/mnt/c/Users/DT/AppData/Roaming/discord/Local Storage'
discord_local = '/mnt/c/Users/DT/AppData/Local/Discord'

def stop(): os.system("taskkill.exe /IM Discord.exe /F")
def start(): os.system(f"{discord_local}/Update.exe --processStart Discord.exe")

def backup():
    name = str(input("Save name > "))
    try: shutil.copytree(f'{discord_roaming}/leveldb/', f'{discord_roaming}/{name}')
    except: pass
    if os.path.isdir(f"{discord_roaming}/{name}"):
        print("Added new account.")
    else: print("Error adding account.")


def restore():
    stop()
    print(os.listdir(discord_roaming))
    name = str(input("Name > "))
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

def remove():
    stop()
    print(os.listdir(discord_roaming))
    name = str(input("Account > "))
    if os.path.isdir(f'{discord_roaming}/{name}'):
        shutil.rmtree(f"{discord_roaming}/{name}")

if __name__ == '__main__':
    if 'new' in sys.argv or '-n' in sys.argv: backup()
    if 'change' in sys.argv or '-c' in sys.argv: restore()
    if 'delete' in sys.argv or '-d' in sys.argv: remove()
    if 'reset' in sys.argv: reset()
    if 'start' in sys.argv: start()
    if 'stop' in sys.argv: stop()
