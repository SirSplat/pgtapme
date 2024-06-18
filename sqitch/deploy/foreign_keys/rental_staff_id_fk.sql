-- Deploy db_design_intro:foreign_keys/rental_staff_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.rental
    ADD CONSTRAINT rental_staff_id_fk FOREIGN KEY (staff_id) REFERENCES rental.staff(staff_id);

COMMIT;
