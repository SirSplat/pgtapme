-- Verify db_design_intro:sequences/payment_payment_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.payment_payment_id_seq', 'usage' );

ROLLBACK;
