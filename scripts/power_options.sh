#!/bin/bash

# Define the options
options="Logout\nShutdown\nReboot\nSuspend\nHibernate"

# Function to prompt for choice in st
prompt_choice() {
    st -e sh -c "echo -e '$1' && read -p 'Enter your choice: ' choice && echo \$choice"
}

# Use st to select an option
selected=$(prompt_choice "$options")

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
    *)
        echo "Invalid option: $selected"
        ;;
esac
