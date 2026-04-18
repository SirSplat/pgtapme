-- Deploy pgtapme_dev:foreign_tables/remote_items to pg
-- requires: user_mappings/dbo_fdw_source

BEGIN;

CREATE FOREIGN TABLE pgtapme.remote_items (
    id integer NOT NULL,
    label text NOT NULL
)
SERVER fdw_source_server
OPTIONS (schema_name 'fdw_source', table_name 'remote_items');

COMMIT;
