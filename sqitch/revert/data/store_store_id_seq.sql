-- Revert db_design_intro:data/store_store_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.store_store_id_seq', 1, true);

COMMIT;
