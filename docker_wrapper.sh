#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PIALERT=/pialert/config/pialert.conf

if [[ -f $PIALERT ]]
then
  echo "$PIALERT already exists"
else
  /tmp/pialert.sh
fi

#NOTE: Start lighttpd
service lighttpd restart

/bin/bash
