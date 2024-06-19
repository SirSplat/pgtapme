-- Revert db_design_intro:tables/actor from pg

BEGIN;

DROP TABLE rental.actor;

COMMIT;
