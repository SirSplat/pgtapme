-- Deploy db_design_intro:data/customer_customer_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.customer_customer_id_seq', 599, true);

COMMIT;
