-- Deploy db_design_intro:data/inventory_inventory_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.inventory_inventory_id_seq', 4581, true);

COMMIT;
