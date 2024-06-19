-- Verify db_design_intro:views/sales_by_film_category on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.sales_by_film_category', 'select' );

ROLLBACK;
