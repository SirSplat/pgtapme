-- Revert db_design_intro:data/city_city_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.city_city_id_seq', 1, true);

COMMIT;
