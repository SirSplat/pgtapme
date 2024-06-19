-- Deploy db_design_intro:data/country_country_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.country_country_id_seq', 109, true);

COMMIT;
