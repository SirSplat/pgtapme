-- Revert db_design_intro:data/rental_rental_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.rental_rental_id_seq', 1, true);

COMMIT;
