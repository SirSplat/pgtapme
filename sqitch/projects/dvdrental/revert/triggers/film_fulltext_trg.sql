-- Revert db_design_intro:triggers/film_fulltext_trg from pg

BEGIN;

DROP TRIGGER fulltext_trg ON rental.film;

COMMIT;
