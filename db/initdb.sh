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
ESQL

psql -v ON_ERROR_STP=1 --username "dbo" --dbname "postgres" <<-ESQL
    CREATE DATABASE dvdrental TEMPLATE template1;
    COMMENT ON DATABASE dvdrental IS 'Home of dvdrental database. this attempts to use all manner of DDL, DML.';
    ALTER DATABASE dvdrental SET search_path TO rental,sqitch,pgtap;

    CREATE DATABASE pgtapme TEMPLATE template1;
    COMMENT ON DATABASE pgtapme IS 'Home of pgtapme test database. this attempts to use all manner of DDL, DML.';
    ALTER DATABASE pgtapme SET search_path TO pgtapme,exts,sqitch,pgtap;
ESQL

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    ALTER ROLE dbo WITH NOSUPERUSER;
ESQL
