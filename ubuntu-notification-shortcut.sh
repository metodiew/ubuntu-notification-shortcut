#!/bin/bash

# Author: Stanko Metodiev
# Author Email: stanko@metodiew.com
# Author URL: https://metodiew.com
# Description:  This is a script enabling/disabling the OS notifiications
# How to use:   Clone the repository or copy the file. Place it somewhere in the file system.
#               chmod +x ubuntu-notification-shortcut
#               Open the Settings > Keyboard > Keyboard Shortcodes > Custom Shortoces
#               Set the name, place the path to file, e.g. /home/<user>/Software/ubuntu-notification-shortcut and select the keyboard combination

# Toggle notifications for both Ubuntu (GNOME) and Linux Mint (Cinnamon).
# Use only gsettings checks so the script has no extra tool dependencies.
if gsettings describe org.cinnamon.desktop.notifications display-notifications >/dev/null 2>&1; then
  schema="org.cinnamon.desktop.notifications"
  key="display-notifications"
elif gsettings describe org.gnome.desktop.notifications show-banners >/dev/null 2>&1; then
  schema="org.gnome.desktop.notifications"
  key="show-banners"
else
  notify-send "Notifications toggle failed: unsupported desktop schema"
  exit 1
fi

# Get the current state of the notification mode.
state=$(gsettings get "$schema" "$key")

if [[ "$state" == "true" ]]; then
  notify-send "Notifications: disabled"
  sleep 0.1
  gsettings set "$schema" "$key" false
else
  gsettings set "$schema" "$key" true
  notify-send "Notifications: enabled"
fi