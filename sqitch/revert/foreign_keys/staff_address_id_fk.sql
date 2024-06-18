-- Revert db_design_intro:foreign_keys/staff_address_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.staff
    DROP CONSTRAINT staff_address_id_fk;

COMMIT;
