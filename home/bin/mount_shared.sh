CNAME=`uname -n`
case $CNAME in
    "icemilk")
	mount -t smbfs //gcs6@sherbert.partners.org/shared $HOME/shared
	;;
    *)
	sudo mount -t cifs -o user=gcs6,uid=$USER //sherbert.partners.org/shared $HOME/shared
	;;
esac
