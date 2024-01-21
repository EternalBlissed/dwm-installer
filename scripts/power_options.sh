#!/bin/bash

# Define the options
options="Logout\nShutdown\nReboot\nSuspend\nHibernate"

# Use dmenu to select an option
selected=$(echo -e $options | dmenu -i -p "Power Menu: ")

# Execute the selected option
case $selected in
    Logout)
        # Replace this with the command to log out from your dwm session
        pkill dwm
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Suspend)
        systemctl suspend
        ;;
    Hibernate)
        systemctl hibernate
        ;;
esac
