#!/bin/bash

# Terminate already running bars
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
polybar desktop 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
