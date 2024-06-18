-- Revert db_design_intro:data/inventory_inventory_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.inventory_inventory_id_seq', 1, true);

COMMIT;
