import datetime
import os
import shutil

# Current Working Directory set
mac_dir = '/Users/drake/Documents/Wallpaper Project'
win_dir = 'R:/Red/Wallpaper Project'
os.chdir(win_dir)
print('CWD:', os.getcwd())

# Set date format
date = datetime.date.today()
dateFormat = f'{date.month}-{date.day}-{date.year}'
print('Date Format Set:', dateFormat)

# Set File names
macName = f'{dateFormat} - Mac.tif'
print('Mac File Names Set:', macName)
winName = f'{dateFormat} - Win.tif'
print('Windows File Names Set:', winName)

# Copy files to history folder
shutil.copy('Mac.tif', 'history/')
print('Copied: Mac.tif > History/')
shutil.copy('Win.tif', 'History/')
print('Copied: Win.tif > History/')

# Renaming with dateFormat
shutil.move(f'History/Mac.tif', f'History/{macName}')
print(f'Renamed: Mac.tif > {macName}')
shutil.move(f'History/Win.tif', f'History/{winName}')
print(f'Renamed: Win.tif > {winName}')
