#!/bin/bash
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
#
# Database
#
export DATABASE="slskirjasto";
export DBUSER="sls";
export DBPASSWORD="*";
export DBHOST="localhost";
export DBREPORTUSER="slsreport";
export DBREPORTUSERPASSWORD="*"
export MATVIEWGROUP="slsmaterial"

#
# Old database
#
export OLDDATABASE="slskirjastoold";
#
# Bash documentation
#
export BASHDOCDIR=$DDIR/docs/bash
export BASHSOURCEDIR=$DDIR/bin
for i in `find $BASHSOURCEDIR -name '*.sh' -printf "%f "|sed 's/\.sh/.md/g'`; do
    BASHDOCTGTS="$BASHDOCTGTS $BASHDOCDIR/$i"
done
export BASHDOCTGTS;

#
# Schema documentation
#
export SCHEMASPY=/home/mos/javalib/schemaspy-6.1.0.jar
export PGSQLJDBC=/opt/DbVisualizer/jdbc/postgresql/postgresql.jar
export SCHEMADOCS=$DDIR/doc/schema
export OLDSCHEMADOCS=$DDIR/doc/oldschema

#
# Web
#
export DOCWEBROOT=/var/www/html/slskirjasto_api