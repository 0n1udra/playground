#!/bin/sh
ssh desktop "python3 /home/0n1udra/git/playground/scripts/desktop_powerdown.py shutdown"
sudo -u arcpy python3 /home/arcpy/git/playground/scripts/powerdown.py ups
