#!/bin/bash
# @file bin/createviews.sh
# @brief Creates database views
# @description Uses params.sh to pull in configuration and dbhelper.sh to fetch psql execution functions.

DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS
source $DDIR/bin/dbhelper.sh

SQLBASE=$DDIR/sql

cd $DDIR
VIEWS=$SQLBASE/views
for i in ownergroupmembers.sql; do
    psqlfile $VIEWS/$i || exit 1
done
