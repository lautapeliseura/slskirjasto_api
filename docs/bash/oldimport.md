# bin/oldimport.sh

Import data from old slskirjasto database

## Overview

Uses params.sh to pull in configurable variables and dbhelper.sh to fetch psql execution function.
Imports views to the old database if they don't yet exist.
Does some "cleanup" on the olddatabase before import.



