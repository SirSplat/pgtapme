-- Verify db_design_intro:functions/film_not_in_stock(integer-integer)-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.film_not_in_stock(integer, integer)', 'execute' );

ROLLBACK;
