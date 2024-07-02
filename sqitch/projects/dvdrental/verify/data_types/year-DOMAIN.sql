-- Verify db_design_intro:data_types/year-DOMAIN on pg

BEGIN;

SELECT pg_catalog.pg_typeof(1901::rental.year);

ROLLBACK;
