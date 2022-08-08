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

Ah yes.... the irony. Pi.Alert and it isn't even supported on ARM to run on Raspberry Pi. I know. When I was testing this I was making it for x86-64. I will be working to add support for Raspberry Pi this week.

# Deployment

## Docker Compose

```
docker run -it -d --net host --name=pialert redteamcafe/pialert
```

## Docker CLI

*Prefered Method*

```
version: '3'

services:
  pialert:
    image: redteamcafe/pialert:latest
    container_name: pialert
    environment:
      PUID: 1000
      PGID: 1000
    volumes:
      - /pialert
# For the time being, I am commenting these out and using the host network until I can figure out the arp-scan
#    ports:
#      - 8080:80
    network_mode: "host"
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
| `-v ./pialert:/pialert` | location where pialert data is stored |

REPORT_MAIL False
REPORT_TO 'user@gmail.com'
SMTP_SERVER='smtp.gmail.com'
SMTP_PORT=587
SMTP_USER='user@gmail.com'
SMTP_PASS='password'

# Future Contributions and Features
* Support for ARM for Raspberry Pi (SOON)
* Figure out a way to have pialert deployed without using the host network


