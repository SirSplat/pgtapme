-- Revert db_design_intro:data/actor from pg

BEGIN;

TRUNCATE TABLE rental.actor;

COMMIT;
