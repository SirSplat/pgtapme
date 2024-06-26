#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    COMMENT ON ROLE dbo IS 'Database object owner.';
    GRANT pg_read_server_files, pg_read_all_settings TO dbo;
ESQL

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "template1" <<-ESQL
    CREATE SCHEMA pgtap;
    COMMENT ON SCHEMA pgtap IS 'Home of all things PGTap.';
    CREATE EXTENSION pgtap WITH SCHEMA pgtap;

    CREATE SCHEMA partman;
    COMMENT ON SCHEMA partman IS 'Home of all things pg_partman.';
    CREATE EXTENSION pg_partman WITH SCHEMA partman;
ESQL

psql -v ON_ERROR_STP=1 --username "dbo" --dbname "postgres" <<-ESQL
    CREATE DATABASE dvdrental TEMPLATE template1;
    COMMENT ON DATABASE dvdrental IS 'Home of dvdrental database. this attempts to use all manner of DDL, DML.';
    ALTER DATABASE dvdrental SET search_path TO rental,sqitch,pgtap,partman;

    CREATE DATABASE dvdrental_alt TEMPLATE template1;
    COMMENT ON DATABASE dvdrental_alt IS 'Home of dvdrental_alt database. This attempts to use design and performance best pratices.';
    ALTER DATABASE dvdrental_alt SET search_path TO rental,sqitch,pgtap,partman;

    CREATE DATABASE pgtapme TEMPLATE template1;
    COMMENT ON DATABASE pgtapme IS 'Home of pgtapme test database. this attempts to use all manner of DDL, DML.';
    ALTER DATABASE pgtapme SET search_path TO pgtapme,pgtapme_ext,sqitch,pgtap,partman;

    CREATE DATABASE manager TEMPLATE template0;
    COMMENT ON DATABASE manager IS 'Home of database management tools. Such as pg_cron.';
ESQL

psql -v ON_ERROR_STP=1 --username "dbo" --dbname "manager" <<-ESQL
    CREATE EXTENSION pg_cron;
ESQL

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    ALTER ROLE dbo WITH NOSUPERUSER;
ESQL
