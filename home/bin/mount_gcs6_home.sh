#! /bin/sh

CNAME=`uname -n`
case $CNAME in
    "malus")
	sudo mount -t cifs -o user=gcs6,uid=gsharp //cifshd.partners.org/homedir$ /home/gsharp/gcs6_home
	;;
    *)
	sudo mount -t cifs -o user=gcs6,uid=gcs6 //cifshd.partners.org/homedir$ /PHShome/gcs6/gcs6_home
	;;
esac
