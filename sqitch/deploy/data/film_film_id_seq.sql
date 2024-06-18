-- Deploy db_design_intro:data/film_film_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.film_film_id_seq', 1000, true);

COMMIT;
