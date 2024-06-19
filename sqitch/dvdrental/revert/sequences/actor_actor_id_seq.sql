-- Revert db_design_intro:sequences/actor_actor_id_seq from pg

BEGIN;

DROP SEQUENCE rental.actor_actor_id_seq;

COMMIT;
