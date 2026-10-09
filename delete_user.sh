#!/usr/bin/env bash

set -euo pipefail

usage() {
    printf 'Usage: %s [--remove-home] USERNAME\n' "${0##*/}" >&2
}

remove_home=false
username=

for arg in "$@"; do
    case "$arg" in
        --remove-home)
            if [[ "$remove_home" == true ]]; then
                usage
                exit 2
            fi
            remove_home=true
            ;;
        -*)
            usage
            exit 2
            ;;
        *)
            if [[ -n "$username" ]]; then
                usage
                exit 2
            fi
            username=$arg
            ;;
    esac
done

if [[ -z "$username" || ! "$username" =~ ^[a-zA-Z_][a-zA-Z0-9_.-]*$ ]]; then
    usage
    exit 2
fi

if (( EUID != 0 )); then
    printf 'Error: run this script as root (for example, with sudo).\n' >&2
    exit 1
fi

passwd_entry=$(getent passwd "$username") || {
    printf 'Error: user "%s" does not exist.\n' "$username" >&2
    exit 1
}

IFS=: read -r _ _ user_id _ <<< "$passwd_entry"
if [[ "$user_id" == 0 ]]; then
    printf 'Error: refusing to delete a root account.\n' >&2
    exit 1
fi

if [[ -n "${SUDO_USER:-}" && "$username" == "$SUDO_USER" ]]; then
    printf 'Error: refusing to delete the account running this script via sudo.\n' >&2
    exit 1
fi

if [[ "$remove_home" == true ]]; then
    userdel --remove "$username"
else
    userdel "$username"
fi
