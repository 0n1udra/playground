import discord, time, os, sys, datetime
from discord.ext import commands, tasks

with open('/home/slime/crombit_token.txt', 'r') as file: TOKEN = file.readline()

bot = commands.Bot(command_prefix='~')

def lprint(arg1=None, arg2=None):
    if type(arg1) is str:
        msg = arg1
        user = 'Script'
    else:
        try: user = arg1.message.author
        except: user = 'N/A'
        msg = arg2

    print(f"{datetime.datetime.now()} | ({user}) {msg}")

@bot.event
async def on_ready():
    await bot.wait_until_ready()
    print("Crombit Bot PRIMED.")

@bot.command(aliases=['remind', 'r'])
async def reminder(ctx, *args):
    if not len(args) > 1:
        await ctx.send("Missing a time or message argument, or both. Exmaple: `~r 5m Swag time!`")
        return

    msg = ' '.join(args[1:])

    try: set_time = int(args[0][:-1])
    except:
        await ctx.send("**Error:** Parsing time argument.")
        return
    m = args[0][-1]
    if m == 's': multiplier = 1
    elif m == 'm': multiplier = 60
    elif m == 'h': multiplier = 120
    else:
        await ctx.send("**Error:** Parsing time denotation. Examples: `10s`, `5m`, `1h`.")
        return

    await ctx.send("**Reminder set!**")

    time.sleep(set_time * multiplier)
    await ctx.send(f"(Reminder from {ctx.message.author.mention}): " + msg)
    lprint(ctx, f"Reminder {args[0]}: {msg}")


@bot.command(aliases=['restartcrombit', 'rcrombit', 'rebootcrom', 'restart', 'reboot'])
async def bot_restart(ctx):
    #os.chdir(os.getcwd)
    await ctx.send("***Rebooting Bot...***")
    os.execl(sys.executable, sys.executable, *sys.argv)

bot.run(TOKEN)





