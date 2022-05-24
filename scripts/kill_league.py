import psutil, sys

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


if __name__ == '__main__':


    if 'list' in sys.argv:
        for i in procs: print(i)

    if 'kill' in sys.argv:
        kill_procs(procs)
        exit()

    if len(sys.argv) > 1:
        for i in get_proc(sys.argv[1]): print(i)
