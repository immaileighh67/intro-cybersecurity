#!/bin/bash

set -euo pipefail

usage() {
    echo "Usage: $0 [--remove-home] <username>" >&2
    exit 1
}

remove_home=false

if [[ $# -eq 0 || $# -gt 2 ]]; then
    usage
fi

if [[ $# -eq 2 ]]; then
    if [[ "$1" != "--remove-home" ]]; then
        usage
    fi
    remove_home=true
    username="$2"
else
    username="$1"
fi

if [[ ! "$username" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    echo "Invalid username: $username" >&2
    exit 1
fi

if ! id "$username" >/dev/null 2>&1; then
    echo "User '$username' does not exist." >&2
    exit 1
fi

if [[ "$remove_home" == true ]]; then
    userdel --remove-home "$username"
else
    userdel "$username"
fi

echo "Deleted user: $username"
