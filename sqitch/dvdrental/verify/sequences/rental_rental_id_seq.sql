-- Verify db_design_intro:sequences/rental_rental_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.rental_rental_id_seq', 'usage' );

ROLLBACK;
