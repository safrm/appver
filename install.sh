#/bin/sh
#easier way how to handle version formats http://safrm.net/projects/appver/
#author:  Miroslav Safr <miroslav.safr@gmail.com>
BINDIR=/usr/bin/
MANDIR=/usr/share/man

#root check
USERID=`id -u`
[ $USERID -eq "0" ] || {
    echo "I cannot continue, you should be root or run it with sudo!"
    exit 0
}

#test
sh -n ./appver
if  [ $? != 0 ]; then
	echo "syntax error in appver, exiting.."
	exit 1
fi

. ./appver
install -m 0777 -v ./appver  $BINDIR
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=$APP_FULL_VERSION_TAG/" $BINDIR/appver && rm -f $BINDIR/appver.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=$APP_BUILD_DATE/" $BINDIR/appver && rm -f $BINDIR/appver.bkp

MANPAGES=`find ./doc/manpages -type f`
install -d -m 755 $MANDIR/man1
install -m 644 $MANPAGES $MANDIR/man1


