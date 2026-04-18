-- Deploy pgtapme_dev:user_mappings/dbo_fdw_source to pg
-- requires: servers/fdw_source_server

BEGIN;

CREATE USER MAPPING FOR dbo
    SERVER fdw_source_server
    OPTIONS (user 'dbo', password 'mysecretpassword');

COMMIT;
