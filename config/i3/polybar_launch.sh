#!/usr/bin/env bash

# Add Nix profile paths to PATH
export PATH=$PATH:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar on all monitors
echo "--- Polybar Launch $(date) ---" > /tmp/polybar.log
if type "xrandr"; then
  echo "xrandr found, searching for monitors..." >> /tmp/polybar.log
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo "Launching on monitor: $m" >> /tmp/polybar.log
    MONITOR=$m polybar --reload main --config=/home/gerkules/nixos-configuration/config/i3/polybar_config.ini >> /tmp/polybar.log 2>&1 &
  done
else
  echo "xrandr not found, launching default" >> /tmp/polybar.log
  polybar --reload main --config=/home/gerkules/nixos-configuration/config/i3/polybar_config.ini >> /tmp/polybar.log 2>&1 &
fi
