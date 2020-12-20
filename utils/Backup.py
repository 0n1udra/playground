# version 1
import os
import time


# stuff = []

def backup():
    check = os.path.isfile('boo.txt')
    check2 = os.path.isfile('foo.txt')
    if check == False or check2 == False:
        print(':(')
        print('restoring it!')
        os.system('cp -b backup/boo.txt ./ && cp -b backup/foo.txt ./')
        backup()
    else:
        print('its fine')
        time.sleep(5)
        backup()


backup()
# version 2
import os, time

files = {
    "name": ["normal location", "backup location"]
    "test_file": ["home/kirby/Desktop/test.txt", "home/backup/test.txt"]
}
print(files)  # prints files in 'files' list


def backup2():
    global files
    for n, l in files.items():  # checks if file exist, n - name, l - location
        check = os.path.isfile(l)  # checks each file from list to see if it's ok
        if check is False:
            print(n, "IS MISSING!!!")  # prints that 'n' file is missing
            print("NORMAL LOCATION > ", l[0], "BACKUP LOCATION > ", l[1])  # prints the locations for the file
            try:
                print("RESTORING...........")
                os.system("cp -b " + l[1] + l[0])  # tries to restore the file
                print("All Good")
            except:
                print("ooops! something went wrong"), exit()  # something is wrong
        else:
            continue
