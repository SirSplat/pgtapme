-- Deploy db_design_intro:data/address_address_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.address_address_id_seq', 605, true);

COMMIT;
