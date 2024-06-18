-- Deploy db_design_intro:data_types/mpaa_rating-ENUM to pg
-- requires: appschema

BEGIN;

CREATE TYPE rental.mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);

COMMIT;
