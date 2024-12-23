# What is this
pgTAPme is an application written in [Python](https://www.python.org/) which generates [pgTAP](https://pgtap.org/) style tests using a [PostgreSQL](https://www.postgresql.org/) database. It provides a modular and extensible framework to create tests for different aspects of your database schema. These tests can then be executed using the [pg_prove docker image](https://hub.docker.com/r/itheory/pg_prove/).

# Why do this (re-invent the wheel)?
I did this to for a few reasons:
* To learn [Python](https://www.python.org/)
* But more so to learn the intricacies of [pgTAP](https://pgtap.org/) (inside [PostgreSQL](https://www.postgresql.org/), not the [Perl](https://www.perl.org/) code)
* I don't like the output format [pg_tapgen](https://github.com/theory/tap-parser-sourcehandler-pgtap/blob/v3.36/bin/pg_tapgen) produces
* So I had to learn [pgTAP](https://github.com/theory/tap-parser-sourcehandler-pgtap) and [pg_prove](https://github.com/theory/tap-parser-sourcehandler-pgtap) Perl code anyway :) Learned a lot.

# How to use this
## Start the cluster

    docker compose up -d

## Initialize the pgtapme database, lets first try get the status

    docker compose exec -it sqitch sqitch status pgtapme --chdir /mnt/migrations

This will produce output similar to:

    # On database pgtapme
    Database pgtapme has not been initialized for Sqitch

## Now initialize the the pgtapme database

    docker compose exec -it sqitch sqitch deploy pgtapme --chdir /mnt/migrations

This will produce output similar to:

    Adding registry tables to pgtapme
    Deploying changes to pgtapme
      + appschema ................................................. ok
      + comments/appschema ........................................ ok
      + extschema ................................................. ok
      + comments/extschema ........................................ ok
      + gist_ext .................................................. ok
      + comments/gist_ext ......................................... ok
      + tables/lkp_dow ............................................ ok
      + comments/lkp_dow .......................................... ok
      + functions/lkp_dow_populate-date-date ...................... ok
      + comments/lkp_dow_populate-date-date ....................... ok
      + tables/lkp_mth ............................................ ok
      + comments/lkp_mth .......................................... ok
      .
      .
      .
      + rules/d_date_rule_create_insert_rule ...................... ok
      + rules/d_date_rule_create_update_rule ...................... ok
      + rules/d_date_rule_create_delete_rule ...................... ok
      + data/d_date_rule_populate_partitions @v1.0 ................ ok

That output is a good thing, you can see the final TAG "@v1.0", this matches the TAG from your sqitch.plan

    @v1.0 2024-07-02T11:37:18Z dbo <dbo@pgtapme.com> # Tag v1.0 of pgtapme.py development database

## Finally we get to execute the pgtapme.py, lets use the --help argument first

    docker compose exec -it app python pgtapme.py --help

The output of this is:

    usage: pgtapme.py [-h] [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--module-type MODULE_TYPE] [--db-name DATABASE_NAME] [--db-user DATABASE_USER]
                  [--db-password DATABASE_USER_PASSWORD] [--db-host DATABASE_HOST] [--db-port DATABASE_PORT]

    Your script description

    options:
      -h, --help            show this help message and exit
      --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                            Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
      --module-type MODULE_TYPE
                            Override module types
      --db-name DATABASE_NAME
                            Override database name
      --db-user DATABASE_USER
                            Override database user
      --db-password DATABASE_USER_PASSWORD
                            Override database user password
      --db-host DATABASE_HOST
                            Override database host
      --db-port DATABASE_PORT
                            Override database port

## So lets create the pgTAP style tests for our pgtapme database

    docker compose exec -it app python pgtapme.py

By default pgtapme.py does not produce output, unless something went wrong or you passed the --log-level argument

## Testing pgtapme.py output, does it match our sqitch deployed database

    docker compose exec -it pg_prove pg_prove --ext .sql -r -U dbo -h pgtapme_db -d pgtapme -p 5432 -f /mnt/tests/pgtapme

This should produce output similar to:

    /mnt/tests/pgtapme/cluster/cluster.sql ............................................................................................................................ ok
    /mnt/tests/pgtapme/cluster/language/c.sql ......................................................................................................................... ok
    /mnt/tests/pgtapme/cluster/language/internal.sql .................................................................................................................. ok
    /mnt/tests/pgtapme/cluster/language/plpgsql.sql ................................................................................................................... ok
    /mnt/tests/pgtapme/cluster/language/sql.sql ....................................................................................................................... ok
    /mnt/tests/pgtapme/cluster/role/dbo.sql ........................................................................................................................... ok
    /mnt/tests/pgtapme/cluster/role/pg_checkpoint.sql ................................................................................................................. ok
    /mnt/tests/pgtapme/cluster/role/pg_create_subscription.sql ........................................................................................................ ok
    /mnt/tests/pgtapme/cluster/role/pg_database_owner.sql ............................................................................................................. ok
    /mnt/tests/pgtapme/cluster/role/pg_execute_server_program.sql ..................................................................................................... ok
    .
    .
    .
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/indexes/tags_pkey.sql ............................................................................. ok
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/indexes/tags_project_tag_key.sql .................................................................. ok
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/tags.sql .......................................................................................... ok
    All tests successful.
    Files=2520, Tests=27102, 85 wallclock secs ( 4.34 usr  2.14 sys + 50.08 cusr  5.31 csys = 61.87 CPU)
    Result: PASS

If everything went well, but if something failed you should see something output similar to:

    .
    .
    .
    /mnt/tests/pgtapme/databases/pgtapme/schemas/pgtapme/tables/lkp_dow/indexes/lkp_dow_short_name_ic_uidx.sql ........................................................ ok
    /mnt/tests/pgtapme/databases/pgtapme/schemas/pgtapme/tables/lkp_dow/lkp_dow.sql ................................................................................... 1/20
    not ok 6 - Table pgtapme.lkp_dow should have the correct columns.
    # Failed test 6: "Table pgtapme.lkp_dow should have the correct columns."
    #     Extra columns:
    #         ive_broken_it
    # Looks like you failed 1 test of 20
    /mnt/tests/pgtapme/databases/pgtapme/schemas/pgtapme/tables/lkp_dow/lkp_dow.sql ................................................................................... Failed 1/20 subtests
    /mnt/tests/pgtapme/databases/pgtapme/schemas/pgtapme/tables/lkp_mth/columns/fk.sql ................................................................................ ok
    .
    .
    .
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/indexes/tags_pkey.sql ............................................................................. ok
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/indexes/tags_project_tag_key.sql .................................................................. ok
    /mnt/tests/pgtapme/databases/pgtapme/schemas/sqitch/tables/tags/tags.sql .......................................................................................... ok

    Test Summary Report
    -------------------
    /mnt/tests/pgtapme/databases/pgtapme/schemas/pgtapme/tables/lkp_dow/lkp_dow.sql                                                                                 (Wstat: 0 Tests: 20 Failed: 1)
    Failed test:  6
    Files=2479, Tests=26589, 79 wallclock secs ( 4.09 usr  2.30 sys + 44.94 cusr  5.06 csys = 56.39 CPU)
    Result: FAIL

And there you have it. A complete suite of pgTAP tests, just what DBA's always wanted developers todo - DEVELOP DATABASE SCHEMA TESTS :)

I've provided the original [pgtapme-v1.0.tgz](pg_prove/pgtapme-v1.0.tgz) for reference.

# Whats coming next?
* Add a scraper to get available pgTAP tests from [pgTAP](https://pgtap.org/)
* Determine which code.src.writers are required and create them if they don't exist or replace them if the syntax has changed
* Determine which code.src.getters are required and create them if they don't exist or replace them if the syntax has changed
* Determine which code.src.module_types they belong to and create new module_types or update existing module_types
* I'm sure I'll think of more at some point

Just as an FYI here. I have no idea how I'm going to acheive that, but I'm going to give it my best shot. So don't hold your breath for those releases, it may take a while :)

# Copyright and License
[MIT License](./LICENSE)

[Copyright pgTAP](./copyright_pgtap.md)
