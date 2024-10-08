#!/bin/bash

if [ "$1" == "-i" ]; then
    echo "Flag set";
    mysql --host=mysql --user=root -proot -e "CREATE USER 'cacti'@'0.0.0.0' IDENTIFIED BY 'cacti';" && \
	mysql --host=mysql --user=root -proot -e "GRANT ALL ON cacti.* TO 'cacti'@'0.0.0.0';" && \
	mysql --host=mysql --user=root -proot cacti < /usr/share/doc/cacti/cacti.sql && \
	mysql --host=mysql --user=root -proot -e "GRANT ALL PRIVILEGES ON mysql.time_zone_name TO 'cacti'@'%' WITH GRANT OPTION;FLUSH PRIVILEGES;"

fi

/usr/sbin/cron -f &
/usr/sbin/apachectl -D FOREGROUND
