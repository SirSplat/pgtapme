-- Verify db_design_intro:foreign_keys/city_country_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'city_country_id_fk' AND
    conrelid = 'rental.city'::regclass AND
    contype = 'f';

ROLLBACK;
