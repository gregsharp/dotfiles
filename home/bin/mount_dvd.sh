#sudo mount -t iso9660 /dev/sr0 /mnt/dvd/
HOSTNAME=`uname -n`
if test $HOSTNAME = "wormwood"; then
    echo "Hi wormwood"
    sudo mount -t udf,iso9660 \
	-o uid=gsharp,gid=gsharp,dmode=0777 /dev/sr0 /mnt/dvd
else
    echo "Sorry, you are not wormwood"
    sudo mount -t udf,iso9660 \
	-o uid=gcs6,gid=PosixUsers,dmode=0777 /dev/sr0 /mnt/dvd
fi

