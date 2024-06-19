-- Revert db_design_intro:sequences/film_film_id_seq from pg

BEGIN;

DROP SEQUENCE rental.film_film_id_seq;

COMMIT;
