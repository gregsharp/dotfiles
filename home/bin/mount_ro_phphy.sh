#! /bin/sh

CNAME=`uname -n`
case $CNAME in
    "malus")
	sudo mount -t cifs -o user=gcs6,uid=gsharp //cifs2.partners.org/ro_phphy$ /home/gsharp/ro_phphy
	;;
    *)
	sudo mount -t cifs -o user=gcs6,uid=gcs6 //cifs2.partners.org/ro_phphy$ /PHShome/gcs6/ro_phphy
	;;
esac
