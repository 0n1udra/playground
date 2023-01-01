#!/usr/bin/python3
import psutil, time, os, sys
from extra import lprint

filename = 'desktop_powerdown.py'

def wait_shutdown():
    """Waits 5min, then shutdown system."""

    print("Shutdown in 5min")
    os.system("spd-say -t female2 'Warning, power failure. Shutdown in 5 minutes.' && wall 'Power failure. Shutdown in 5min'")
    time.sleep(300)
    os.system('poweroff')

def kill_shutdown():
    """Aborts shutdown."""

    for proc in psutil.process_iter():
        if len(proc.cmdline()) > 1:
            if 'desktop_powerdown.py' in proc.cmdline()[1]: proc.kill()


if __name__ == '__main__':

    if 'shutdown' in sys.argv:
        lprint(filename, 'WARN: Desktop powering down')
        wait_shutdown()
    if 'stop' in sys.argv:
        lprint(filename, 'INFO: Desktop shutdown aborted')
        kill_shutdown()
