import datetime, discord, sys, os

token_file = f'{os.getenv("HOME")}/keys/matsumoto.token'
bot_path = os.path.dirname(os.path.abspath(__file__))
log_file = f'{os.getenv("HOME")}/system_log.txt'
channel_id = 965114735248953424

if os.path.isfile(token_file):
    with open(token_file, 'r') as file: TOKEN = file.readline()
else:
    print("Missing Token File:", token_file)
    sys.exit()

bot = discord.Client(command_prefix='.')

def lprint(msg): print(f'{datetime.today()} | {msg}')

msg = ''

@bot.event
async def on_ready():
    global msg
    await bot.wait_until_ready()
    channel = bot.get_channel(channel_id)
    await channel.send(msg)
    await bot.close()

if __name__ == '__main__':
    if len(sys.argv) > 1:
        msg = sys.argv[1]

        bot.run(TOKEN)
