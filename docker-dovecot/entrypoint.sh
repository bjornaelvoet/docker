#!/bin/sh

# Set up the dovecot users and passwords
while read line; do
  username=$line
  read line
  password=$line
  password_encrypt=$(doveadm pw -s plain -p $password -u $username)
  echo "$username:$password_encrypt:$DOVECOT_USERID:$DOVECOT_GROUPID::/maildata/home_dovecot/$username::userdb_quota_rule=*:storage=$DOVECOT_USER_QUOTA" >> /etc/dovecot/dovecot.passwd 
done < /conf/$DOVECOT_USERS_PASSWORDS

# Create user for dropping priviliges
# vmail:vmail used in dovecot conf file
addgroup -g $DOVECOT_MAIL_GROUPID vmail
adduser -D -H -G vmail -g vmail -h /dev/null -s /sbin/nologin -u $DOVECOT_MAIL_USERID vmail

# Import user maildir
if [ "$DOVECOT_IMPORT" = true ]; then
  dovecot -F -c /conf/$DOVECOT_CONF_FILE $DOVECOT_OPTIONS &
  sleep 5
  doveadm $DOVECOT_IMPORT_OPTIONS import -u $DOVECOT_IMPORT_USERNAME maildir:/import bjorn_aelvoet all
  exit 0
fi

# Start dovecot
dovecot -F -c /conf/$DOVECOT_CONF_FILE $DOVECOT_OPTIONS

