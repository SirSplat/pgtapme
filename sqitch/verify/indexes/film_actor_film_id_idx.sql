-- Verify db_design_intro:indexes/film_actor_film_id_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'film_actor' AND
    pg_indexes.indexname = 'film_actor_film_id_idx';

ROLLBACK;
