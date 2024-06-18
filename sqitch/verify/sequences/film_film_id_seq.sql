-- Verify db_design_intro:sequences/film_film_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.film_film_id_seq', 'usage' );

ROLLBACK;
