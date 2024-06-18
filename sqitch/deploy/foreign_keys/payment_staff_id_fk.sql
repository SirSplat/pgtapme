-- Deploy db_design_intro:foreign_keys/payment_staff_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.payment
    ADD CONSTRAINT payment_staff_id_fk FOREIGN KEY (staff_id) REFERENCES rental.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
