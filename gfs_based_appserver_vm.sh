#!/usr/bin/env bash

echo "--|| Wybierz szblon ||--"
echo "dostępne"
virsh list --inactive | grep template | awk '{ print "- " $2}'
read TEMPLATE
echo "--|| Podaj hostname nowej maszyny ||--"
read HOSTNAME

virt-clone --connect qemu:///system --original ${TEMPLATE} --name ${HOSTNAME}.invirt.lan \
    --file /inditexhw/images/${HOSTNAME}.invirt.lan.qcow2


export TMPDIR=/tmp
virt-sysprep  --enable=net-hostname,udev-persistent-net,dhcp-client-state,dhcp-server-state,net-hwaddr,tmp-files,udev-persistent-net,customize -d ${HOSTNAME}.invirt.lan --hostname ${HOSTNAME}
unset TMPDIR
