#!/bin/bash

# Check if HDMI-1 is connected
if xrandr | grep "HDMI-1 connected"; then
    # Set HDMI-1 as primary and to the left of eDP-1
    xrandr --output HDMI-1 --auto --primary --left-of eDP-1 --mode 1920x1080 --output eDP-1 --mode 1920x1200
else
    # Set eDP-1 as the primary display
    xrandr --output eDP-1 --auto --primary
fi

feh --bg-scale ~/Pictures/revachol.jpg
