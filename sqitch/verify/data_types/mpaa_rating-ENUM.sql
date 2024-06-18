-- Verify db_design_intro:data_types/mpaa_rating-ENUM on pg

BEGIN;

SELECT pg_catalog.pg_typeof('PG'::rental.mpaa_rating);

ROLLBACK;
