-- Revert db_design_intro:triggers/actor_last_updated_trg from pg

BEGIN;

DROP TRIGGER last_updated_trg ON rental.actor;

COMMIT;
