-- Verify db_design_intro:sequences/staff_staff_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.staff_staff_id_seq', 'usage' );

ROLLBACK;
