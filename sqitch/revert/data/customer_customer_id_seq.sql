-- Revert db_design_intro:data/customer_customer_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.customer_customer_id_seq', 1, true);

COMMIT;
