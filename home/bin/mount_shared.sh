CNAME=`uname -n`
case $CNAME in
    "icemilk")
	mount -t smbfs //gcs6@sherbert.partners.org/shared $HOME/shared
	;;
    "debian")
	sudo mount -t cifs -o user=gcs6,uid=dev //sherbert.partners.org/shared $HOME/shared
	;;
    *)
	sudo mount -t cifs -o user=gcs6,uid=gcs6 //sherbert.partners.org/shared $HOME/shared
	;;
esac
