-- Revert db_design_intro:foreign_keys/rental_customer_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.rental
    DROP CONSTRAINT rental_customer_id_fk;

COMMIT;
