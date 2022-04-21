import datetime, os

log_file = f'{os.getenv("HOME")}/system.log'
if not os.path.exists(log_file):
    file = open(log_file, 'w+')
    file.close()

def lprint(ctx, text):
    """Prints and Logs events in file."""

    output = f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] ({ctx}): {text}"

    # Logs output.
    with open(log_file, 'a') as file: file.write(output + '\n')
