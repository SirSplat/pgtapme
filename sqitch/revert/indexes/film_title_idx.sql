-- Revert db_design_intro:indexes/film_title_idx from pg

BEGIN;

DROP INDEX rental.film_title_idx;

COMMIT;
