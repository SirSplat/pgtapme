-- Verify db_design_intro:sequences/country_country_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.country_country_id_seq', 'usage' );

ROLLBACK;
