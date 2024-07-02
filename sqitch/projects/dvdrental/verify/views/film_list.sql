-- Verify db_design_intro:views/film_list on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.film_list', 'select' );

ROLLBACK;
