#!/bin/sh

if [ "$RSNAPSHOT_TEST" = true ]; then
  # Do some sanity checking on the conf files and dryruns
  rsnapshot -c /conf/$RSNAPSHOT_CONF_FILE configtest
  rsnapshot -t -c /conf/$RSNAPSHOT_CONF_FILE hourly
  rsnapshot -t -c /conf/$RSNAPSHOT_CONF_FILE daily
  rsnapshot -t -c /conf/$RSNAPSHOT_CONF_FILE weekly
  rsnapshot -t -c /conf/$RSNAPSHOT_CONF_FILE monthly
  rsnapshot -c /conf/$RSNAPSHOT_CONF_FILE du 
fi

# prepare crontab for root
touch /etc/crontabs/root

# At noon and midnight backups
echo "0 */12 * * * rsnapshot $RSNAPSHOT_OPTIONS -c /conf/$RSNAPSHOT_CONF_FILE hourly" >> /etc/crontabs/root

# Daily backups starting every day at 00u50 am
echo "50 0 * * * rsnapshot $RSNAPSHOT_OPTIONS -c /conf/$RSNAPSHOT_CONF_FILE daily" >> /etc/crontabs/root
  
# Weekly backups starting every week at 11u50 on Monday 
echo "50 11 * * 1 rsnapshot $RSNAPSHOT_OPTIONS -c /conf/$RSNAPSHOT_CONF_FILE weekly" >> /etc/crontabs/root
  
# Montly backups starting every first day of the month at 12u50
echo "50 12 1 * * rsnapshot $RSNAPSHOT_OPTIONS -c /conf/$RSNAPSHOT_CONF_FILE monthly" >> /etc/crontabs/root
  
# start cron - we should be done!
/usr/sbin/crond -f
