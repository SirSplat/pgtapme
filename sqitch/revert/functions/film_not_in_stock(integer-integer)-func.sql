-- Revert db_design_intro:functions/film_not_in_stock(integer-integer)-func from pg

BEGIN;

DROP FUNCTION rental.film_not_in_stock(integer, integer);

COMMIT;
