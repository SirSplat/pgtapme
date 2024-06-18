-- Deploy db_design_intro:data/actor_actor_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.actor_actor_id_seq', 200, true);

COMMIT;
