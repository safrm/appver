#!/bin/sh
#web: http://safrm.net/projects/appver
#author: Miroslav Safr <miroslav.safr@gmail.com> 
#old version of jss-docs-update to avoid cyclic dependency
#first argument passes release version for releasing package builds


command_exists () {
    command -v "$1" 1>/dev/null 2>&1 ;
}

if ! command_exists xsltproc ; then
	echo "xsltproc does not exist, exiting.."
	exit 1
fi

MANXSL=/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl
if [ ! -e $MANXSL ]; then
	MANXSL=http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
fi

HTMLXSL=/usr/share/xml/docbook/stylesheet/docbook-xsl/html/docbook.xsl
if [ ! -e $HTMLXSL ]; then
	HTMLXSL=http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
fi

#automatic version to avoid package recures
#if command -v appver &>/dev/null ; then . appver ; else APP_SHORT_VERSION=NA ; APP_FULL_VERSION_TAG=NA ; APP_BUILD_DATE=`date +'%Y%m%d_%H%M'` ; fi
. ../appver $1

#first syntax and DTD check
if  command_exists jss-xml-validator ; then
	jss-xml-validator  ./ -dtd /usr/share/sgml/docbook/dtd/xml/4.5/docbookx.dtd
	if [ $? != 0 ]; then
		echo "Syntax errors"
		exit 1
	fi
else
	echo  "Syntax and validity check skipped (install jenkins-support-scripts..)"
fi

TEMP_DIR=./tmp
rm -fr $TEMP_DIR && mkdir $TEMP_DIR
#update version and date
for PAGEXML in $(  find . -type f -name "*1.xml" )
do
    cp $PAGEXML $TEMP_DIR/
    sed -i".bkp" "1,/<productnumber>/s/<productnumber>.*/<productnumber>$APP_SHORT_VERSION_TAG<\/productnumber>/" $TEMP_DIR/$PAGEXML && rm -f $TEMP_DIR/$PAGEXML.bkp
    sed -i".bkp" "1,/<\/date>/s/<date>.*/<date>$APP_BUILD_DATE<\/date>/" $TEMP_DIR/$PAGEXML && rm -f $TEMP_DIR/$PAGEXML.bkp
done

#generate man and html pages
for PAGEXML in $(  find ./tmp -type f -name "*1.xml" )
do
	PAGENAME=`basename $PAGEXML .1.xml`
	xsltproc -o ./htmlpages/$PAGENAME.html $HTMLXSL $PAGEXML
	xsltproc -o ./manpages/$PAGENAME.1 $MANXSL $PAGEXML
done
