-- Revert db_design_intro:foreign_keys/rental_staff_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.rental
    DROP CONSTRAINT rental_staff_id_fk;

COMMIT;
