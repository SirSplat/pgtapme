# What is this
PGtapme is a [Python](https://www.python.org/) tool for generating [pgTAP](https://pgtap.org/) style tests using a [PostgreSQl](https://www.postgresql.org/) database. It provides a modular and extensible framework to create tests for different aspects of your database schema. These tests can then be executed using [pg_prove docker image](https://hub.docker.com/r/itheory/pg_prove/).

<!-- # <p style='color:red'>***This is still very much a work in progress - USE AT YOUR OWN RISK***</p> -->

# Why do this - re-invent the wheel?
I did this to for a few reasons:
* To learn [Python](https://www.python.org/)
* But more so to learn the intricacies of [pgTAP](https://pgtap.org/) (inside [PostgreSQL](https://www.postgresql.org/), not the [Perl](https://www.perl.org/) code)
* I don't like the output format [pg_tapgen](https://github.com/theory/tap-parser-sourcehandler-pgtap/blob/v3.36/bin/pg_tapgen) produces
* So I had to learn [pgTAP]() and [pg_prove]() Perl code anyway :)

# How to use this
## Start the cluster

    docker compose up -d

## Create the pgtapme database

    docker compose exec pgtapme_db bash /code/initdb.sh

 This will produce output simiar to:

    CREATE DATABASE
    COMMENT
    ALTER DATABASE

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

    docker compose exec -it app python pgtapme.py --help

By default pgtapme.py does not produce output, unless something went wrong or you passed the --log-level argument

## Testing pgtapme.py output, does it match our sqitch deployed database

    docker 

# Copyright and License

Copyright © 2019-2024 Leon Rogers. Some rights reserved.

Permission to use, copy, modify, and distribute this software and its documentation for any purpose, without fee, and without a written agreement is hereby granted, provided that the above copyright notice and this paragraph and the following two paragraphs appear in all copies.

IN NO EVENT SHALL LEON ROGERS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF LEON ROGERS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

LEON ROGERS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND LEON ROGERS HAS NO OBLIGATIONS TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.