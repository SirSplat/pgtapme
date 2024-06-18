-- Verify db_design_intro:tables/film_category on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.film_category', 'insert' );

ROLLBACK;
