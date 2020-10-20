#!/bin/sh

# We need to sleep for some minutes as dovecot does not start upon reboot due to an (yet to) unresovled dependency
sleep 5m

# Start dovecot
dovecot -F -c /conf/$DOVECOT_CONF_FILE $DOVECOT_OPTIONS

