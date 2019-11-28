#!/bin/sh
pkill -f st_quake || st -t st_quake -e tmux new-session -A -s quake
