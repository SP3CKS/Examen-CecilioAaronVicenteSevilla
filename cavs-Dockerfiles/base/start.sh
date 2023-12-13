#!/bin/bash

USUARIO=$CAVStaller
DOMINIO=$CAVStaller.es
NAMEHOST1=$CAVStallerX1
NAMEHOST2=$CAVStallerX2
NAMEHOST3=$CAVSX3
CONTEXTO=$CAVSContexto
IDRSA=$CAVSIDRSA

log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

ping -c 4 8.8.8.8 > /logs/ping_log.txt
log "Ping a 8.8.8.8 realizado. Ver /logs/ping_log.txt para detalles."

grep -q $USUARIO /etc/passwd || (adduser $USUARIO && log "Nuevo usuario $USUARIO creado.")
log "Usuario $USUARIO verificado o creado correctamente."

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
service ssh restart
log "Configuración de SSH realizada correctamente."

echo "172.80.10.1 $NAMEHOST1.$DOMINIO" >> /etc/hosts
echo "172.80.10.2 $NAMEHOST2.$DOMINIO" >> /etc/hosts
echo "172.80.10.3 $NAMEHOST3.$DOMINIO" >> /etc/hosts
log "MiniDNS local configurado correctamente."

ping -c 4 $NAMEHOST2.$DOMINIO > /logs/ping_log_taller1_taller2.txt
ping -c 4 $NAMEHOST3.$DOMINIO > /logs/ping_log_taller1_taller3.txt
ping -c 4 $NAMEHOST1.$DOMINIO > /logs/ping_log_taller2_taller1.txt
ping -c 4 $NAMEHOST3.$DOMINIO > /logs/ping_log_taller2_taller3.txt
ping -c 4 $NAMEHOST1.$DOMINIO > /logs/ping_log_taller3_taller1.txt
ping -c 4 $NAMEHOST2.$DOMINIO > /logs/ping_log_taller3_taller2.txt
log "Ping entre servidores realizado correctamente. Ver logs para detalles."

ssh -i $IDRSA $CONTEXTO@$NAMEHOST3.$DOMINIO > /logs/ssh_log_taller2_taller3.txt
log "SSH desde taller2 a taller3 realizado correctamente. Ver /logs/ssh_log_taller2_taller3.txt para detalles."
