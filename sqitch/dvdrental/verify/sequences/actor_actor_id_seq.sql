-- Verify db_design_intro:sequences/actor_actor_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.actor_actor_id_seq', 'usage' );

ROLLBACK;
