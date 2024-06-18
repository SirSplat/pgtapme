-- Revert db_design_intro:foreign_keys/store_manager_staff_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.store
    DROP CONSTRAINT store_manager_staff_id_fk;

COMMIT;
