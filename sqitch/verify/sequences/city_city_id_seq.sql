-- Verify db_design_intro:sequences/city_city_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.city_city_id_seq', 'usage' );

ROLLBACK;
