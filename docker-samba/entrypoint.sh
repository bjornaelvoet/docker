#!/bin/sh

# Set up family group
addgroup -g 1001 family 

#adduser -D -H -G rio -s /bin/false -u 1000 rio

# Set up the samba users and passwords
while read line; do
  username=$line
  read line
  password=$line
  read line
  userid=$line
  #adduser -D -H -G rio -s /bin/false -u 1000 rio
  adduser -s /sbin/nologin -h /home/samba -H -D $username -u $userid -G family
  printf "%s\n%s\n" "$password" "$password" | smbpasswd -sa $username
done < $SAMBA_USERS

# Start samba
smbd --foreground --no-process-group --log-stdout --configfile /conf/$SAMBA_CONF_FILE $SAMBA_OPTIONS
