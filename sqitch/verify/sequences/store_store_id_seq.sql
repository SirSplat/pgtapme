-- Verify db_design_intro:sequences/store_store_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.store_store_id_seq', 'usage' );

ROLLBACK;
