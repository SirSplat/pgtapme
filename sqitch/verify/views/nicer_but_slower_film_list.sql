-- Verify db_design_intro:views/nicer_but_slower_film_list on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.nicer_but_slower_film_list', 'select' );

ROLLBACK;
