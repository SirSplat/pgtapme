-- Revert db_design_intro:indexes/film_fulltext_idx from pg

BEGIN;

DROP INDEX rental.film_fulltext_idx;

COMMIT;
