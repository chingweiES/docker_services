# Construct a master-slave replication environment for PostgreSQL

## Concept

1. In a master-slave environment, the data must be identical, so the slave database will perform a base backup from the master database before starting.
2. After the slave database starts, it will continuously receive updates from the master database.

## Startup Process

1. Start master database, the master database will initialize and start up.
2. Start slave database, the slave database will first check if it already has data. If not, it will perform a base backup from the master database and then start the slave database.


## Connect to db

* User can connect to both master and slave using the same credentials, but they will be read/write on master and read-only on slave.
* user can also connect to the proxy, which will automatically route read/write queries to master and read-only queries to slave.
