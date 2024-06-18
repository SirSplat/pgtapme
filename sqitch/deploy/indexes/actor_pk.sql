-- Deploy db_design_intro:indexes/actor_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.actor
    ADD CONSTRAINT actor_pk PRIMARY KEY (actor_id);

COMMIT;
