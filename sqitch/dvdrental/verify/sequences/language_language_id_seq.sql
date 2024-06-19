-- Verify db_design_intro:sequences/language_language_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.language_language_id_seq', 'usage' );

ROLLBACK;
