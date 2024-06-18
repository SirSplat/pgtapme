-- Deploy db_design_intro:foreign_keys/rental_inventory_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.rental
    ADD CONSTRAINT rental_inventory_id_fk FOREIGN KEY (inventory_id) REFERENCES rental.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
