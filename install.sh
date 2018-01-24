#/bin/sh
#easier way how to handle version formats http://safrm.net/projects/appver/
#author:  Miroslav Safr <miroslav.safr@gmail.com>
. ./appver
. ./appver-installer

appver_basic_scripts_test

$MKDIR_755 $BINDIR
$INSTALL_755 ./appver $BINDIR
$INSTALL_755 ./appver-installer $BINDIR
appver_update_version_and_date $BINDIR/appver
