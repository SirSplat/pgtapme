-- Deploy db_design_intro:data/rental_rental_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.rental_rental_id_seq', 16049, true);

COMMIT;
