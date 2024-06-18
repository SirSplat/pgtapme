-- Revert db_design_intro:indexes/actor_pk from pg

BEGIN;

ALTER TABLE ONLY rental.actor
    DROP CONSTRAINT actor_pk;

COMMIT;
