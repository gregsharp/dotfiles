#! /bin/sh

CNAME=`uname -n`
case $CNAME in
    "malus")
	sudo mount -t cifs -o user=gcs6,uid=gsharp //cifs2.partners.org/homedir$ /home/gsharp/gcs6_home
	;;
    *)
	sudo mount -t cifs -o user=gcs6,uid=gcs6 //cifs2.partners.org/homedir$ /PHShome/gcs6/gcs6_home
	;;
esac
