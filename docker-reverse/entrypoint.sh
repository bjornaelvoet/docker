#!/bin/sh

# Set up the samba users and passwords
while read line; do
  username=$line
  read line
  password=$line
  adduser -s /sbin/nologin -h /home/samba -H -D $username
  printf "%s\n%s\n" "$password" "$password" | smbpasswd -sa $username
done < $SAMBA_USERS

# Start samba
smbd --foreground --no-process-group --log-stdout --configfile /conf/$SAMBA_CONF_FILE $SAMBA_OPTIONS
