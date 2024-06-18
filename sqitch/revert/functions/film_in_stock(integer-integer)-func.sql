-- Revert db_design_intro:functions/film_in_stock(integer-integer)-func from pg

BEGIN;

DROP FUNCTION rental.film_in_stock(integer, integer);

COMMIT;
