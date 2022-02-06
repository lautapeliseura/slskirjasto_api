# bin/dbhelper.sh

Helper functions to provide psql executions

## Overview

Provides functions to execute sql commands agains new and old slskirjasto databases with psql.
Requires existence of params.sh file for global paramerization.

## Index

* [psqlexecute()](#psqlexecute)
* [psqlaexecute()](#psqlaexecute)
* [psqlfile()](#psqlfile)
* [psqloldfile()](#psqloldfile)

### psqlexecute()

Execute single query/command on the new database

#### Arguments

* **$1** (string): command to execute
#### Exit codes

* **0**: if successfull
* **1**: if failed

### psqlaexecute()

Execute single query/command on the postgres database

#### Arguments

* **$1** (string): command to execute
#### Exit codes

* **1**: if failed

* **0**: if successfull
### psqlfile()

Execute file of sql-queries/statements on the the new database

#### Arguments

* **$1** (string): filename to execute
#### Exit codes

* **0**: if successfull
* **1**: if failed

### psqloldfile()

Execute file of sql-queries/statements on the old database

#### Arguments

* **$1** (string): filename to execute
#### Exit codes

* **1**: if failed

* **0**: if successfull
