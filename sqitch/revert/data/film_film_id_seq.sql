-- Revert db_design_intro:data/film_film_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.film_film_id_seq', 1, true);

COMMIT;
