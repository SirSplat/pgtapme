-- Revert db_design_intro:data/actor_actor_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.actor_actor_id_seq', 1, true);

COMMIT;
