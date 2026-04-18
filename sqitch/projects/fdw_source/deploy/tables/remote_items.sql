-- Deploy fdw_source:tables/remote_items to pg
-- requires: appschema

BEGIN;

CREATE TABLE fdw_source.remote_items (
    id serial PRIMARY KEY,
    label text NOT NULL
);

COMMIT;
