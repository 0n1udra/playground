import datetime, inspect, os

# Creates log file in ~/ if not exist
log_file = f'{os.getenv("HOME")}/system.log'
if not os.path.exists(log_file):
    file = open(log_file, 'w+')
    file.close()

def dmsg(msg):
    try: src = inspect.stack()[1].filename
    except: src = None

    os.system(f"python3 ~/git/playground/scripts/matsumoto.py '({src}) {msg}'")

# For printing and logging events
def lprint(location, text):
    """Prints and Logs events in file."""

    output = f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] ({location}): {text}"

    # Logs output.
    with open(log_file, 'a') as file: file.write(output + '\n')
    print(output)
