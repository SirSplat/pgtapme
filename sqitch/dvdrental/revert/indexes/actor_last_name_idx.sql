-- Revert db_design_intro:indexes/actor_last_name_idx from pg

BEGIN;

DROP INDEX rental.actor_last_name_idx;

COMMIT;
