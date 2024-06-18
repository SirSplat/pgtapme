-- Deploy db_design_intro:foreign_keys/store_manager_staff_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.store
    ADD CONSTRAINT store_manager_staff_id_fk FOREIGN KEY (manager_staff_id) REFERENCES rental.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
