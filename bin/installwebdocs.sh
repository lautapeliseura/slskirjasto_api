#!/bin/bash -x
#@file bin/installwebdocs.sh
#@brief Installs documentation to web-directory
#@description Cleans old files from target web-directory and copies
#current documentation files to it.
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS

srcdirs="$SCHEMADOCS $OLDSCHEMADOCS"
for i in $srcdirs; do 
    if [ -d $i ]; then
        j=${i##*/}
        tgt=$DOCWEBROOT/$j
        if [ -d $tgt ]; then
            rm -rf $tgt
            mkdir $tgt
        fi
        cp -r $i/ $tgt/
    fi
done 

if [ -d $DDIR/site ]; then
    for i in $(find $DDIR/site -type d -print); do
        j=${i#site/}
        case j in 
            site)
                rm $DOCWEBROOT/*
                ;;
            php-reports)
                echo "Danger Will Robinsson! php-reports!"
                exit 1
                ;;
            reports)
                echo "Danger Will Robinsson! reports!"
                exit 1
                ;;
            *)
                if [ -d $DOCWEBROOT/$j ]; then
                    rm -rf $DOCWEBROOT/$j
                fi
                ;;
        esac
    done
    cp -r site/* $DOCWEBROOT
fi            
