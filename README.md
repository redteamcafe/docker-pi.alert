[![redteamcafe.com](https://github.com/redteamcafe/docker-temp/raw/main/redteamcafe-logo.png)](https://redteamcafe.com)

Red Team Cafe is an organization dedicated to information technology and security.

We are proud to bring you one of our docker containers!

# [redteamcafe/docker-pi.alert](https://github.com/redteamcafe/docker-pi.alert)

[![Pi.Alert](https://raw.githubusercontent.com/redteamcafe/docker-pi.alert/main/1_devices.jpg)](https://github.com/pucherot/Pi.Alert)

## About this Build

* 

Pi Alert is a WiFi and LAN intrusion alerting system that detects and alerts when unknown devices are connected to the network as well as alerting when known "always connected" devices are disconnected from the network.

Currently supported:
* x86-64

# Deployment

## Docker Compose

```
docker run -it -d --name=sphinx-rtd redteamcafe/sphinx-rtd
```

## Docker CLI

*Prefered Method*

```
version: '3'

services:
  sphinx-rtd:
    image: redteamcafe/sphinx-rtd:latest
    container_name: sphinx-rtd
    environment:
      PROJECT_NAME: sphinx
      PROJECT_AUTHOR: sphinx
      PUID: 1000
      PGID: 1000
    volumes:
      - /docs
    ports:
      - 8080:80
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    restart: unless-stopped
```
## Parameters
| Parameter | Function |
| :----: | --- |
| `-p 8080:80` | webserver port for accessing PiAlert |
| `-e PUID=1000` | set UserID |
| `-e PGID=1000` | set GroupID |
| `-e REPORT_MAIL=True` | Set to 'True' |
| `-e REPORT_TO='user@gmail.com'` | name of the Sphinx project author |
| `-e SMTP_SERVER='smtp.gmail.com'` | 
| `-e SMTP_PORT=587` | |
| `-e SMTP_USER='user@gmail.com'` | |
| `-e SMTP_PASS='password'` | |
| `-v ./pialert:/pialert` | location where pialert data is stored |

REPORT_MAIL False
REPORT_TO 'user@gmail.com'
SMTP_SERVER='smtp.gmail.com'
SMTP_PORT=587
SMTP_USER='user@gmail.com'
SMTP_PASS='password'

# Future Contributions and Features
* Environmental variables that enable options for HTML, PDF and EPub documentation (when not declared, default to HTML)
* Environmental variables that allow Sphinx Autobuild to be disabled (when not declared, enable by default)



