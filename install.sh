#/bin/sh
BINDIR=/usr/bin/
./appver || APP_FULL_VERSION_TAG=NA
sudo install -m 0777 -v ./appver  $BINDIR

