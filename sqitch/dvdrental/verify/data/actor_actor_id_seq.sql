-- Verify db_design_intro:data/actor_actor_id_seq on pg

BEGIN;

SELECT
    1 / COUNT( sequencename )
FROM
    pg_catalog.pg_sequences
WHERE
    schemaname = 'rental' AND
    sequencename = 'actor_actor_id_seq';

ROLLBACK;
