import discord, sys, os
from discord.ext import commands
from extra import lprint

# Not for running 24/7, just to send a message to the channel

location = 'matsumoto.py'  # Where log message coming from

token_file = f'{os.getenv("HOME")}/keys/matsumoto_bot.token'
bot_path = os.path.dirname(os.path.abspath(__file__))
log_file = f'{os.getenv("HOME")}/system_log.txt'
channel_id = 965114735248953424

if os.path.isfile(token_file):
    with open(token_file, 'r') as file: TOKEN = file.readline()
else:
    print("Missing Token File:", token_file)
    sys.exit()

intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix='.', case_insensitive=True, intents=intents)
msg = ''

@bot.event
async def on_ready():
    global msg
    try:
        await bot.wait_until_ready()
        channel = bot.get_channel(channel_id)
        await channel.send(msg)
    except:  # If something fails, bot won't stay running.
        exit()
    await bot.close()
    lprint(location, f"INFO: Message sent: {msg}")

if __name__ == '__main__':
    if len(sys.argv) > 1:
        msg = ' '.join(sys.argv[1:])
        bot.run(TOKEN)

