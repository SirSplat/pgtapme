-- Deploy db_design_intro:data/payment_payment_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.payment_payment_id_seq', 32098, true);

COMMIT;
