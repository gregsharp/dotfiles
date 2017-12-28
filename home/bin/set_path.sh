#! /bin/sh

CNAME=`uname -n`
case $CNAME in
    "absinthe")
	export PATH=$PATH:$HOME/build/plastimatch-3.20.0
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    "gelato")
	export PATH=$HOME/build/plastimatch:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    "icecream")
	export PATH=$HOME/build/plastimatch:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    "redfish")
	export PATH=$PATH:$HOME/build/plastimatch-3.18.0
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    "sherbert")
	export PATH=$HOME/build/plastimatch:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    "wormwood")
	#export PATH=$PATH:$HOME/build/plastimatch-deb
	export PATH=$HOME/build/plastimatch-4.8.2:$PATH
	export PATH=$PATH:$HOME/work/plastimatch/extra/perl
	export PATH=$PATH:$HOME/work/plastimatch/extra/vw
	;;
    *)
	echo "Unknown machine"
	;;
esac
