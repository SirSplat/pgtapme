#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "postgres" <<-ESQL
    CREATE DATABASE fdw_source TEMPLATE template1;
    COMMENT ON DATABASE fdw_source IS 'Remote source database for FDW testing.';
    ALTER DATABASE fdw_source SET search_path TO fdw_source,pgtap;
ESQL
