-- Revert db_design_intro:data/payment_payment_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.payment_payment_id_seq', 1, true);

COMMIT;
