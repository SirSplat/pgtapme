-- Deploy pgtapme_dev:servers/fdw_source_server to pg

BEGIN;

CREATE SERVER fdw_source_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'fdw_source', dbname 'fdw_source', port '5432');

COMMIT;
