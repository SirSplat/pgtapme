-- Revert db_design_intro:data/language_language_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.language_language_id_seq', 1, true);

COMMIT;
