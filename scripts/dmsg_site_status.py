import requests, os
from extra import lprint
# Checks liquor_site status, if offline sends Discord message.

response = requests.get('http://arcpy.asuscomm.com')
if not response.ok:
    lprint('dmsg_site_status.py', 'WARN: Liquor site unreachable.')
    os.system("python3 ~/git/playground/scripts/matsumoto.py Liquor site unreachable")