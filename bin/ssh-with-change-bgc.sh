#!/bin/bash

# Ctrl-C
trap 'echo -e "Interrupted.\033]1337;SetColors=bg=000\a"; exit;' INT

echo -ne '\033]1337;SetColors=bg=200\a' # to red
/usr/bin/ssh "$@"
echo -ne '\033]1337;SetColors=bg=000\a' # to black
