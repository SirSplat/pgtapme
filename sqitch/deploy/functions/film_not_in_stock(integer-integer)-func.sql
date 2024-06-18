-- Deploy db_design_intro:functions/film_not_in_stock(integer-integer)-func to pg
-- requires: appschema
-- requires: tables/inventory
-- requires: functions/inventory_in_stock(integer)-func

BEGIN;

CREATE OR REPLACE FUNCTION rental.film_not_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
    SELECT inventory_id
    FROM rental.inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT rental.inventory_in_stock(inventory_id);
$_$;

COMMIT;
