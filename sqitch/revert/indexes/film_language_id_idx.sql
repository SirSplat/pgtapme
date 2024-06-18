-- Revert db_design_intro:indexes/film_language_id_idx from pg

BEGIN;

DROP INDEX rental.film_language_id_idx;

COMMIT;
