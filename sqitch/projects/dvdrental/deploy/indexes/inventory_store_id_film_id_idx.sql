-- Deploy db_design_intro:indexes/inventory_store_id_film_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX inventory_store_id_film_id_idx ON rental.inventory(store_id, film_id);

COMMIT;
