#!/bin/bash

#
# Por: Mateus Cruz
# Script para expansão de disco.

# Solicita a confirmação do usuário para iniciar Script
echo "Este Script realiza alterações nas configurações de disco. Deseja continuar? [s/n]"
read RESPOSTA

# Verifica se o usuário digitou "s" para continuar
test "$RESPOSTA" != s && exit

# Instala pacotes necessários
apt install scsitools

# Escaneia o barramento SCSI
rescan-scsi-bus.sh
lsblk

# Solicita ao usuário o nome da $PARTICAO a ser criada
echo "Informe a partição a ser criada"
read PARTICAO

# Criando o nova partição
gdisk -l /dev/$PARTICAO
gdisk /dev/$PARTICAO
lsblk

# Solicita ao usuário o nome do $VOLUME físico a ser criado com base na última partição
echo "Informe o volume a ser criado"
read VOLUME

# Cria um novo volume Físico com base na última partição criada
pvcreate /dev/$VOLUME

# Listar os parametros do vg e verificar o VG name para usar no proximo passo
vgdisplay

# Solicita ao usuário o $VGNAME
echo "Informe o VG name"
read VGNAME

# Expandindo o volume
vgextend $VGNAME /dev/$VOLUME

# Lista o lvdisplay e solicita ao usuário o $LVPATH
lvdisplay
echo "Informe o LVPATH"
read LVPATH
lvextend -l +100%FREE $LVPATH
lsblk

# Aumentando o Disco
resize2fs $LVPATH
lsblk

# Finaliza o Script
echo "Disco expandido com sucesso!"