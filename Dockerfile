# Alap kép
FROM ubuntu:20.04

# Környezet beállítása
ENV DEBIAN_FRONTEND=noninteractive

# Frissítések és szükséges csomagok telepítése
RUN apt-get update && \
    apt-get install -y snmpd snmp cacti apache2 libapache2-mod-php php php-mysql mariadb-server rrdtool apache2-utils nano && \
    apt-get clean

#configok hozzadasa
ADD https://raw.githubusercontent.com/Paldun/snmp-web/refs/heads/main/snmpd.conf.v2.example /etc/snmp/snmpd.conf.v2.example
ADD https://raw.githubusercontent.com/Paldun/snmp-web/refs/heads/main/snmpd.conf.v3.example /etc/snmp/snmpd.conf.v3.example
ADD https://raw.githubusercontent.com/Paldun/snmp-web/refs/heads/main/start.sh /sbin/start.sh
ADD https://raw.githubusercontent.com/Paldun/snmp-web/refs/heads/main/debian.php /etc/cacti/debian.php


#Start skript add
RUN chmod 755 /sbin/start.sh

# Portok nyitása
EXPOSE 80 161

CMD [ "sh", "-c", "/sbin/start.sh" ]