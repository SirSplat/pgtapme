-- Deploy db_design_intro:data/category_category_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.category_category_id_seq', 16, true);

COMMIT;
