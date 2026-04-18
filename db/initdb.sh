#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "postgres" <<-ESQL
    CREATE DATABASE pgtapme TEMPLATE template1;
    COMMENT ON DATABASE pgtapme IS 'Home of pgtapme database. this attempts to use all manner of DDL, DML.';
    ALTER DATABASE pgtapme SET search_path TO pgtapme,exts,sqitch,pgtap;
ESQL

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "pgtapme" <<-ESQL
    CREATE EXTENSION IF NOT EXISTS postgres_fdw;
    GRANT USAGE ON FOREIGN DATA WRAPPER postgres_fdw TO dbo;
ESQL
