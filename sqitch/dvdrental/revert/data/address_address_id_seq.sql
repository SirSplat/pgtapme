-- Revert db_design_intro:data/address_address_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.address_address_id_seq', 1, true);

COMMIT;
