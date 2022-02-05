#!/bin/bash
# @file bin/createtables.sh
# @brief Creates database tables
# @description Uses params.sh to pull in configuration and dbhelper.sh to fetch psql execution functions.
# Uses php artisan to migrate Laravel internal tables to the database. Some of the tables created in this script reference
# to laravel users-table.

DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS
source $DDIR/bin/dbhelper.sh

SQLBASE=$DDIR/sql

cd $DDIR
php artisan migrate
if [ $? -ne 0 ]; then
    echo "Laravel migrations failed?"
    exit 1
fi

TEMPLATES=$SQLBASE/templates
psqlfile $TEMPLATES/_base.sql || exit 1
TABLES=$SQLBASE/tables

# baskets requires groups and collectiongame
# cards requires lenders
# collectiongames requires groups, collections, games, donors, storages
# collections requires events, groups
# events requires groups
# groupmembers requires groups, users and roles
# groups requires users
# loans requres lenders, collectiongames, games, events
# roles requires users
# shelves requires groups, storages

for i in roles.sql lenders.sql groups.sql groupmembers.sql events.sql donors.sql cards.sql\
 games.sql collections.sql baskets.sql storages.sql shelves.sql collectiongames.sql loans.sql; do
    psqlfile $TABLES/$i || exit 1
done

psqlfile $SQLBASE/initialLoad.sql || exit 1