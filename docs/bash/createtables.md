# bin/createtables.sh

Creates database tables

## Overview

Uses params.sh to pull in configuration and dbhelper.sh to fetch psql execution functions.
Uses php artisan to migrate Laravel internal tables to the database. Some of the tables created in this script reference
to laravel users-table.



