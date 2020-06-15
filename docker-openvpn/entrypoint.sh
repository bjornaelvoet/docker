#!/bin/sh

# Set up NAT so we have try client-to-client VPN
# Note that this requires network=host

iptables -A FORWARD -j ACCEPT
for NETWORK in $( cat /conf/$OPENVPN_CONF_FILE | egrep -i "^[server|route].*[1-9].*[1-9].*[1-9].*[1-9]" | grep -iv ':' | awk '{ print $2"/"$3 }' )
do
  echo "Creating NAT rule for $NETWORK ..."
  iptables -t nat -A POSTROUTING -s $NETWORK -j MASQUERADE -m comment --comment "openvpn NAT rule"
done

openvpn --config /conf/$OPENVPN_CONF_FILE

