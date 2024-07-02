-- Deploy db_design_intro:data/city_city_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.city_city_id_seq', 600, true);

COMMIT;
