-- Verify db_design_intro:sequences/customer_customer_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.customer_customer_id_seq', 'usage' );

ROLLBACK;
