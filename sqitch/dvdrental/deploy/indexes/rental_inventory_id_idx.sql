-- Deploy db_design_intro:indexes/rental_inventory_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX rental_inventory_id_idx ON rental.rental(inventory_id);

COMMIT;
