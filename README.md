# What is this
PGtapme is a [Python](https://www.python.org/) tool for generating [pgTAP](https://pgtap.org/) style tests using a [PostgreSQl](https://www.postgresql.org/) database. It provides a modular and extensible framework to create tests for different aspects of your database schema. These tests can then be executed using [pg_prove docker image](https://hub.docker.com/r/itheory/pg_prove/).

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
    ```
    docker compose exec pgtapme_db bash /code/initdb.sh
    ```

    This will produce output simiar to:
    ```
    # On database pgtapme
    Database pgtapme has not been initialized for Sqitch
    ```

## Initialize the pgtapme database
    ```
    docker compose exec -it sqitch sqitch status pgtapme --chdir /mnt/migrations
    ```
    This will produce output similar to:
    ```
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
    ```
    That output is a good thing, you can see the final TAG "@v1.0" this matches the TAG from your sqitch.plan
    ```
    
    ```
    ```
    docker compose exec -it sqitch sqitch deploy pgtapme --chdir /mnt/migrations
    ```

# License
[MIT License](./LICENSE)

