-- Revert db_design_intro:foreign_keys/inventory_film_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.inventory
    DROP CONSTRAINT inventory_film_id_fk;

COMMIT;
