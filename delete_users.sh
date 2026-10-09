#!/bin/bash

# This script deletes multiple users based on an array of usernames.
#
# Username array
usernames=("atanaka" "alee" "rpatel")

# delete the users by looping through the array
for username in "${usernames[@]}"
do
    sudo  ./delete_user.sh --remove-home -m "$username"
done

echo "Successfully deleted users"
