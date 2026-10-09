# intro-cybersecurity

## Delete a Linux user

Run `delete_user.sh` with `sudo` and the account name. By default, the account
is deleted but its home directory and files are kept:

```sh
sudo ./delete_user.sh username
```

To also remove the user's home directory and mail spool, pass
`--remove-home`. This permanently deletes those files:

```sh
sudo ./delete_user.sh --remove-home username
```
