# Alap kép
FROM ubuntu:20.04

# Környezet beállítása
ENV DEBIAN_FRONTEND=noninteractive

# Frissítések és szükséges csomagok telepítése
RUN apt-get update && \
    apt-get install -y snmpd snmp cacti apache2 libapache2-mod-php php php-mysql mariadb-server rrdtool apache2-utils && \
    apt-get clean

# SNMPd konfiguráció
COPY snmpd.conf.v2.example /etc/snmp/snmpd.conf.v2.example
COPY snmpd.conf.v3.example /etc/snmp/snmpd.conf.v3.example

# Indítási szkript hozzáadása
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Portok nyitása
EXPOSE 80 161

# A konténer indításakor futtatandó szkript
CMD ["/start.sh"]