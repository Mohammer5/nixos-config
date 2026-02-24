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
  PRIMARY=$(xrandr --query | grep " primary" | cut -d" " -f1)
  
  # If no monitor is marked primary, pick the first one from the list
  if [ -z "$PRIMARY" ]; then
    PRIMARY=$(xrandr --query | grep " connected" | cut -d" " -f1 | head -n1)
    echo "No primary found, defaulting tray to: $PRIMARY" >> /tmp/polybar.log
  fi
  
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo "Launching on monitor: $m" >> /tmp/polybar.log
    if [ "$m" == "$PRIMARY" ]; then
      echo "Setting tray on monitor: $m" >> /tmp/polybar.log
      TRAY_POS=right MONITOR=$m polybar --reload main --config=/home/gerkules/nixos-configuration/config/i3/polybar_config.ini >> /tmp/polybar.log 2>&1 &
    else
      TRAY_POS=none MONITOR=$m polybar --reload main --config=/home/gerkules/nixos-configuration/config/i3/polybar_config.ini >> /tmp/polybar.log 2>&1 &
    fi
  done
else
  echo "xrandr not found, launching default" >> /tmp/polybar.log
  polybar --reload main --config=/home/gerkules/nixos-configuration/config/i3/polybar_config.ini >> /tmp/polybar.log 2>&1 &
fi
