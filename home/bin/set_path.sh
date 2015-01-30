#! /bin/sh

CNAME=`uname -n`
case $CNAME in
    "absinthe")
	export PATH=$PATH:$HOME/build/plastimatch-3.20.0
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	;;
    "gelato")
	export PATH=$HOME/build/plastimatch:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	;;
    "redfish")
	export PATH=$PATH:$HOME/build/plastimatch-3.18.0
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	;;
    "sherbert")
	export PATH=$HOME/build/plastimatch:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	;;
    "wormwood")
	#export PATH=$PATH:$HOME/build/plastimatch-deb
	export PATH=$HOME/build/plastimatch-4.4.2:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	;;
    *)
	echo "Unknown machine"
	;;
esac
