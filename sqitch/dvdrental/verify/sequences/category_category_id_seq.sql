-- Verify db_design_intro:sequences/category_category_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.category_category_id_seq', 'usage' );

ROLLBACK;
