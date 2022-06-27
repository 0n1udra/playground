import psutil, sys
from extra import lprint

def get_proc(proc_name, proc_cmdline=None):
    """Returns a process by matching name and argument."""
    procs = []
    for proc in psutil.process_iter():
        try:
            proc.name().lower().index(proc_name.lower())
        except: continue
        else: procs.append(proc)
    return procs

def kill_procs(procs):
    for proc in procs:
        try: proc.kill()
        except: pass

procs = []
procs += get_proc('wine')
procs += get_proc('league')
procs += get_proc('riot')
procs += get_proc('lutris')
procs += get_proc('start')
procs += get_proc('explorer')


if __name__ == '__main__':

    if 'list' in sys.argv:
        for i in procs: print(i)

    if 'kill' in sys.argv:
        # Specify a process name to kill
        if len(sys.argv) > 2:
            procs = get_proc(sys.argv[2])
            kill_procs(procs)
        else:  # Kill all league related processes
            kill_procs(procs)
            lprint('kill_league.py', 'INFO: Killed league related processes')
        exit()

    if len(sys.argv) > 1:
        for i in get_proc(sys.argv[1]): print(i)
