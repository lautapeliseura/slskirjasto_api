#!/bin/bash
# @file bin/schemadoc.sh
# @brief Createas database schema documentation
# @description Runs Schema Spy against database(s) both new and old, old
# if $OLDSCHEMADOCS is defined. Both databases are assumed to exist locally
# and the running user is the current user.
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS
myDBUSER=$(whoami)
myDBPASSWORD=whocares

if [ ! -d $SCHEMADOCS ]; then
    mkdir -p $SCHEMADOCS || (echo "Failed to create $SCHEMADOCS" && exit 1)
fi

java -jar $SCHEMASPY -t pgsql11 -db $DATABASE -o $SCHEMADOCS -u $myDBUSER -host $DBHOST -p $myDBPASSWORD -dp $PGSQLJDBC

if [ $? -ne 0 ]; then
    echo "Schemaspy $SCHEMASPY failed"
    exit 1
fi

if [ ! -z $OLDSCHEMADOCS ]; then
    if [ ! -d $OLDSCHEMADOCS ]; then
        mkdir -p $OLDSCHEMADOCS || (echo "Failed to create $OLDSCHEMADOCS" && exit 1)
    fi;
    java -jar $SCHEMASPY -t pgsql11 -db $OLDDATABASE -o $OLDSCHEMADOCS -u $myDBUSER -host $DBHOST -p $myDBPASSWORD -dp $PGSQLJDBC
    if [ $? -ne 0 ]; then
        echo "Schemaspy failed with old database"
        exit 1
    fi
fi