import datetime

log_file = '~/system_log.txt'

def lprint(ctx, text):
    """Prints and Logs events in file."""

    output = f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] ({ctx}): {text}"

    # Logs output.
    with open(log_file, 'a') as file: file.write(output + '\n')
