-- Deploy db_design_intro:indexes/actor_last_name_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX actor_last_name_idx ON rental.actor(last_name);

COMMIT;
