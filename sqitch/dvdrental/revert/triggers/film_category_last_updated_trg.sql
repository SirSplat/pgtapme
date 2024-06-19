-- Revert db_design_intro:triggers/film_category_last_updated_trg from pg

BEGIN;

DROP TRIGGER last_updated_trg ON rental.film_category;

COMMIT;
