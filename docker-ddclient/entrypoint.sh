#!/bin/sh

cpan install Test::Requires
cpan Data::Validate::IP

# Start ddclient
/app/ddclient -foreground -file /conf/$DDCLIENT_CONF_FILE $DDCLIENT_OPTIONS
