#!/bin/bash

# Apache és MySQL elindítása
service mysql start
service apache2 start

# Várunk, amíg a MySQL teljesen elindul
# sleep 10

echo "DON'T SHUT DOWN THE PC!!"
echo "DON'T SHUT DOWN THE PC!!"
echo "DON'T SHUT DOWN THE PC!!"
echo "DON'T SHUT DOWN THE PC!!"
echo "DON'T SHUT DOWN THE PC!!"
echo "DON'T SHUT DOWN THE PC!!"
echo "The mysql needs rly mutch time to boot up!"

# Cacti adatbázis és felhasználó létrehozása, ha még nem léteznek
if [ ! -d "/var/lib/mysql/cacti" ]; then
    mysql -e "CREATE DATABASE cacti;"
    mysql -e "CREATE USER 'cactiuser'@'localhost' IDENTIFIED BY 'cactipass';"
    mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cactiuser'@'localhost';"
    mysql -e "GRANT SELECT ON mysql.time_zone_name TO 'cactiuser'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "USE cacti; SOURCE /usr/share/doc/cacti/cacti.sql;"
fi

# .htpasswd fájl létrehozása, ha még nem létezik
if [ ! -f /etc/apache2/.htpasswd ]; then
    htpasswd -b -c /etc/apache2/.htpasswd cactiuser cactipass
fi

# SNMPd elindítása
service snmpd start

# Apache napló figyelése, hogy a konténer ne álljon le
# tail -F /var/log/apache2/access.log

#start shell
cd
exec bash -i