-- Revert db_design_intro:views/actor_info from pg

BEGIN;

DROP VIEW rental.actor_info;

COMMIT;
