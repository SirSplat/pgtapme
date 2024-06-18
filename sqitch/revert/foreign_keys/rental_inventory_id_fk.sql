-- Revert db_design_intro:foreign_keys/rental_inventory_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.rental
    DROP CONSTRAINT rental_inventory_id_fk;

COMMIT;
