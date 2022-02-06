#!/bin/bash
# @file bin/oldimport.sh
# @brief Import data from old slskirjasto database
# @description Uses params.sh to pull in configurable variables and dbhelper.sh to fetch psql execution function.
# Imports views to the old database if they don't yet exist.
# Does some "cleanup" on the olddatabase before import.

# Uses php artisan tinker to run import scripts.
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
source $DDIR/params.sh
source $DDIR/bin/dbhelper.sh

OLDIMPORT=$DDIR/oldimport

psqloldfile $OLDIMPORT/cleanPeli.sql || exit 1
# Ensimmäinen siivous jättää vielä kaksi peliä, jotka ovat duplikaatteja eri nimellä
psqloldfile $OLDIMPORT/cleanPeli.sql || exit 1

psqloldexecute "update kokoelmapeli set lahjoittaja='Nestori Lehtonen' where lahjoittaja='Nestori Lehtonen; Geekissä listattua varhaisempi versio arviolta vuodelta 1966';" || exit 1
views="vCollectionGames.sql vCollections.sql vDonors.sql vEvents.sql vGames.sql vLoans.sql"
for i in $views; do
    psqloldfile $OLDIMPORT/$i || exit 1
done;

cd $DDIR
imports="Games Collections Donors Events CollectionGames Loans";
for i in $imports; do
    tgt=${i,,}
    c=$OLDIMPORT/import$i.php
    v=v$i
    psqloldexecute "select * from $v" > $tgt.csv || exit 1
    echo "Exit"|php artisan tinker $c
    if [ $? -ne 1 ]; then
        echo "Execution of php artisan tinker $c failed."
        exit 1
    fi
done

