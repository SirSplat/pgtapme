-- Revert db_design_intro:data/country_country_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.country_country_id_seq', 1, true);

COMMIT;
