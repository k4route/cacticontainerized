FROM ubuntu:latest

MAINTAINER k4

ENV DEBIAN_FRONTEND=noninteractive
RUN apt clean && apt -y update && \
        apt install -y traceroute net-tools iputils-ping tcpdump vim && \
        apt install -y --no-install-recommends apache2 cron && \
        apt install -y --no-install-recommends php-intl

RUN apt install -y --no-install-recommends cacti

RUN chown -R www-data:www-data /usr/share/cacti/site/resource/snmp_queries/ && \
    chown -R www-data:www-data /usr/share/cacti/site/resource/script_server/ && \
    chown -R www-data:www-data /usr/share/cacti/site/resource/script_queries/ && \
    chown -R www-data:www-data /usr/share/cacti/site/scripts/ && \
    crontab -l | { cat; echo "*/1 * * * * /usr/bin/php /usr/share/cacti/site/poller.php > /dev/null 2>&1"; } | crontab -

EXPOSE 80

COPY startup.sh .
COPY config.php /usr/share/cacti/site/include

CMD ["/bin/bash","-c","./startup.sh"]
