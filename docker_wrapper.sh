#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PIALERT=/pialert/config/pialert.conf

echo "Checking for Pi.Alert directories"
if [[ -f $PIALERT ]]
then
  echo "$PIALERT already exists"
else
  echo "$PIALERT" does not exist"
  echo "Installing Pi.Alert"
  /tmp/pialert.sh
fi

echo "Checks complete"
echo "Starting 
Python3 /pialert/back/pialert.py

#NOTE: Start lighttpd
echo "Starting lighttpd service"
service lighttpd start

#NOTE: Start cron
echo "Starting crontab service"
service cron start

echo "Ready"
/bin/bash
sleep infinity
