# bin/createdb.sh

Creates the new database with roles

## Overview

Readds params.sh file and creates named database with two user roles and one group role.
Sets permissions and passwords for the roles. Uses bin/dbhelper.sh for database access functions.

## Index

* [createdbuser()](#createdbuser)

### createdbuser()

Creates a database user if one doesn't already exist

#### Arguments

* **$1** (string): username to create

#### Exit codes

* **0**: if creation succeeded
* **1**: if creation failed

