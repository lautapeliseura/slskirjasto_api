#!/bin/bash
#@file bin/configure.sh
#@brief Template startter file for all scripts
#@description Template file to start a new bash script with
DDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
export DDIR=${DDIR%/bin}
PARAMS=$DDIR/params.sh
source $PARAMS
