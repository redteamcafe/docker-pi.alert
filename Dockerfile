FROM ubuntu

MAINTAINER Christian McLaughlin <info@redteamcafe.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PUID 1000
ENV PGID 1000
ENV REPORT_MAIL False
ENV REPORT_TO 'user@gmail.com'
ENV SMTP_SERVER 'smtp.gmail.com'
ENV SMTP_PORT 587
ENV SMTP_USER 'user@gmail.com'
ENV SMTP_PASS 'password'

SHELL ["/bin/bash", "-c"]

#NOTE: Updating and installing required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    arp-scan \
    cron \
    curl \
    dnsutils \
    lighttpd \
    net-tools \
    php \
    php-cgi \
    php-fpm \
    php-sqlite3 \
    python3 \
    sqlite3 \
    wget
    
#NOTE: Redirect default server page for Lighttpd to PiAlert
RUN mv /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old
RUN ln -s /pialert/install/index.html /var/www/html/index.html

#NOTE: Activate PHP
RUN lighttpd-enable-mod fastcgi-php
RUN service lighttpd restart

#NOTE: Download and Install PiAlert
#NOTE: Remove the 'q' option to enable verbose output (useful for troubleshooting)
RUN wget -q --no-check-certificate https://github.com/pucherot/Pi.Alert/raw/main/tar/pialert_latest.tar -P /
#NOTE Add the 'v' option to enable verbose output (useful for troublehsooting)
RUN tar xf /pialert_latest.tar
RUN rm /pialert_latest.tar

#NOTE: Public Frontend
RUN ln -s /pialert/front /var/www/html/pialert

#NOTE: Configure Webserver
RUN cp /pialert/install/pialert_front.conf /etc/lighttpd/conf-available
RUN ln -s ../conf-available/pialert_front.conf /etc/lighttpd/conf-enabled/pialert_front.conf
RUN service lighttpd restart

#NOTE: Change the default PiAlert path
RUN sed -i "s,'|home/pi|pialert','|pialert'," /pialert/config/pialert.conf

#NOTE Update vendors database
#NOTE These have been commented out due to issues that I am currently troublehsooting and I am just trying to get the Dockerfile to pass
#RUN sed -i 's|sudo||g' /pialert/back/pialert.py
#RUN python3 /pialert/back/pialert.py update_vendors

#NOTE: Change Python to Python3 in pialert.cron
RUN sed -i 's|python|python3|g' pialert/install/pialert.cron

#NOTE: Add crontab jobs
RUN (crontab -l 2>/dev/null; cat /pialert/install/pialert.cron) | crontab -

#NOTE: Add permissions to www-data user
RUN chgrp -R www-data /pialert/db
RUN chmod -R 770 /pialert/db

EXPOSE 80
VOLUME /pialert

COPY docker_wrapper.sh /usr/local/bin/docker_wrapper.sh
RUN chmod +x /usr/local/bin/docker_wrapper.sh
CMD ["bash", "/usr/local/bin/docker_wrapper.sh"]
