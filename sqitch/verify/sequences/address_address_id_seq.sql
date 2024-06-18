-- Verify db_design_intro:sequences/address_address_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.address_address_id_seq', 'usage' );

ROLLBACK;
