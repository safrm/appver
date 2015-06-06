#/bin/sh
#easier way how to handle version formats http://safrm.net/projects/appver/
#author:  Miroslav Safr <miroslav.safr@gmail.com>
. ./appver
. ./appver-installer

basic_scripts_test

$INSTALL_755 ./appver $BINDIR
$INSTALL_755 ./appver-installer $BINDIR
update_version_and_date() $BINDIR/appver

