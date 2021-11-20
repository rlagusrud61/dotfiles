#!/usr/bin/env sh

# Let's first kill all running instances
killall -q polybar

# Let's wait until the instances are closed
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Automatically launch polybar on all monitors
# Stolen from: https://github.com/polybar/polybar/issues/763
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi

echo "Bars launched!"

# Remember to add
# monitor = ${env:MONITOR:} 
# under [bar/main] in polybar/config ! 
