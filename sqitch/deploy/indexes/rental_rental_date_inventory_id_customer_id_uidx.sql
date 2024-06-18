-- Deploy db_design_intro:indexes/rental_rental_date_inventory_id_customer_id_uidx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE UNIQUE INDEX rental_rental_date_inventory_id_customer_id_uidx ON rental.rental USING btree (rental_date, inventory_id, customer_id);

COMMIT;
