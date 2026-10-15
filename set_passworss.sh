#!/bin/bash

# This script sets multiple passwords based on an array of usernames.
#
# Username array
usernames=("chicken" "grass" "blue")

# set a password for users by looping through the array
for username in "${usernames[@]}"
do
    sudo passwd -r "$username"
done

echo "Successfully set passwords"
