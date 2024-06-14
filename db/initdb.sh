#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    GRANT pg_read_server_files TO dbo;
    COMMENT ON ROLE dbo IS 'Database object owner.';
ESQL

psql -v ON_ERROR_STP=1 --username "dbo" --dbname "postgres" <<-ESQL
    CREATE DATABASE dvdrental TEMPLATE template0;
ESQL

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "dvdrental" <<-ESQL
    CREATE SCHEMA pgtap;
    COMMENT ON SCHEMA pgtap IS 'Home of all PGTap DDL, DML.';
    CREATE EXTENSION pgtap WITH SCHEMA pgtap;
    ALTER DATABASE dvdrental SET search_path TO rental,sqitch,pgtap;
ESQL

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    ALTER ROLE dbo WITH NOSUPERUSER;
ESQL
