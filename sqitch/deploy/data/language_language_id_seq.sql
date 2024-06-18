-- Deploy db_design_intro:data/language_language_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.language_language_id_seq', 6, true);

COMMIT;
