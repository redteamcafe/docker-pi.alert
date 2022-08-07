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
    iputils-ping \
    lighttpd \
    net-tools \
    php \
    php-cgi \
    php-fpm \
    php-sqlite3 \
    python3 \
    sqlite3 \
    wget
    
#NOTE: Make the directory for Pi Alert
RUN mkdir /pialert

#NOTE: Redirect default server page for Lighttpd to PiAlert
RUN mv /var/www/html/index.lighttpd.html /var/www/html/index.lighttpd.html.old
RUN ln -s /pialert/install/index.html /var/www/html/index.html

#NOTE: Activate PHP
RUN lighttpd-enable-mod fastcgi-php
RUN service lighttpd restart

COPY pialert.sh /tmp
RUN chmod +x /tmp/pialert.sh
RUN bash /tmp/pialert.sh

RUN mv -R /tmp/pialert/* /pialert

EXPOSE 80
VOLUME /pialert

COPY docker_wrapper.sh /usr/local/bin/docker_wrapper.sh
RUN chmod +x /usr/local/bin/docker_wrapper.sh
CMD ["bash", "/usr/local/bin/docker_wrapper.sh"]
