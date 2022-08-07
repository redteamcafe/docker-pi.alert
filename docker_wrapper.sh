#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#NOTE: Download and Install Pi Alert
#NOTE: Remove the 'q' option to enable verbose output (useful for troubleshooting)
wget -q --no-check-certificate https://github.com/pucherot/Pi.Alert/raw/main/tar/pialert_latest.tar -P /
#NOTE Add the 'v' option to enable verbose output (useful for troublehsooting)
tar xf /pialert_latest.tar
rm /pialert_latest.tar

#NOTE: Public Frontend
ln -s /pialert/front /var/www/html/pialert

#NOTE: Configure Webserver
cp /pialert/install/pialert_front.conf /etc/lighttpd/conf-available
ln -s ../conf-available/pialert_front.conf /etc/lighttpd/conf-enabled/pialert_front.conf
service lighttpd restart

#NOTE: Change the default PiAlert path
sed -i "s,'|home/pi|pialert','|pialert'," /pialert/config/pialert.conf

#NOTE Update vendors database
#NOTE These have been commented out due to issues that I am currently troublehsooting and I am just trying to get the Dockerfile to pass
#RUN sed -i 's|sudo||g' /pialert/back/pialert.py
#RUN python3 /pialert/back/pialert.py update_vendors

#NOTE: Change Python to Python3 in pialert.cron
sed -i 's|python|python3|g' pialert/install/pialert.cron

#NOTE: Add crontab jobs
(crontab -l 2>/dev/null; cat /pialert/install/pialert.cron) | crontab -

#NOTE: Add permissions to www-data user
chgrp -R www-data /pialert/db
chmod -R 770 /pialert/db

#NOTE: Start lighttpd
service lighttpd restart

/bin/bash
