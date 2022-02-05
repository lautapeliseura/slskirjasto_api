#!/bin/bash
# @file bin/dbhelper.sh
# @brief Helper functions to provide psql executions
# @description Provides functions to execute sql commands agains new and old slskirjasto databases with psql.
# Requires existence of params.sh file for global paramerization.
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS

PSQL="psql -A -d $DATABASE -v ON_ERROR_STOP=on -q -t"
PSQLA="psql -A -d postgres -v ON_ERROR_STOP=on -q -t"

OPSQL="psql -A -d $OLDDATABASE -v ON_ERROR_STOP=on -q -t"

# @description Execute single query/command on the new database
# @arg $1 string command to execute
# @exitcode 0 if successfull
# @exitcode 1 if failed
psqlexecute () {
    if [ $# -ne 1 ]; then
        echo "What do you want to execute? ($#) $*"
        return 1
    fi

    res=$($PSQL -c "$1")
    if [ $? -ne 0 ]; then
        echo "SQL: $1 Failed"
        return 1
    fi
    return 0
}

# @description Execute file of sql-queries/statements on the the new database
# @arg $1 string filename to execute
# @exitcode 0 if successfull
# @exitcode 1 if failed
psqlfile () {
     if [ $# -ne 1 ]; then
        echo "Missing file? ($#) $*"
        return 1
    fi

    res=$($PSQL < $1)
    if [ $? -ne 0 ]; then
        echo "SQL: Execution of file $1 Failed"
        return 1
    fi
    return 0
}

# @description Execute command in the old database
# @arg $1 string command to execute
# @exitcode 0 if succeeded
# @exitcode 1 if failed
psqloldexecute ()
{
    if [ $# -ne 1 ]; then
        echo "What do you want to execute? ($#) $*"
        return 1
    fi

    if [ -z "$OLDDATABASE" ]; then
        echo "There is no old database set? ($OLDDATABASE) $*"
        return 1
    fi

    $OPSQL -c "$1" -F ";" 
    if [ $? -ne 0 ]; then
        echo "SQL: $1 Failed"
        return 1
    fi
    return 0
}

# @description Execute file of sql-queries/statements on the old database
# @arg $1 string filename to execute
# @exitcode 0 if successfull
# @exitcode 1 if failed
psqloldfile () {
     if [ $# -ne 1 ]; then
        echo "Missing file? ($#) $*"
        return 1
    fi

    res=$($OPSQL < $1)
    if [ $? -ne 0 ]; then
        echo "SQL: Execution of file $1 Failed"
        return 1
    fi
    return 0
}
