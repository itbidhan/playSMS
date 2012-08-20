#!/bin/bash

PLAYSMS=$1
LANG=$2

if [ -z "$PLAYSMS" ]; then
	echo "Usage   : $0 <playSMS installation path> <language>"
	echo
	echo "Example : $0 /var/www/playsms id_ID"
	echo
	echo "Above example will create new file playsms-language-id_ID.tar.gz"
	echo
	exit 1
fi

if [ -z "$LANG" ]; then
	echo "Usage   : $0 <playSMS installation path> <language>"
	echo
	echo "Example : $0 /var/www/playsms id_ID"
	echo
	echo "Above example will create new file playsms-language-id_ID.tar.gz"
	echo
	exit 1
fi

CWD=$(pwd)

TMP=$(mktemp -d)

cd $PLAYSMS
find . -type d -name "language" | sed -e "s/\/[^\/]*$//" > /tmp/.lang_folders
for i in `cat /tmp/.lang_folders` ; do
	mkdir -p $TMP/$i/language
	cp -rR $i/language/messages.pot $TMP/$i/language/
	cp -rR $i/language/en_US $TMP/$i/language/$LANG
done

find $TMP -type f -name messages.mo -exec rm {} \;

cd $CWD

mv $TMP playsms-language-$LANG
tar -zcvf playsms-language-$LANG.tar.gz playsms-language-$LANG
rm -rf playsms-language-$LANG

exit 0
