#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    GRANT pg_read_server_files TO dbo;
    COMMENT ON ROLE dbo IS 'Database object owner.';
ESQL
