-- Deploy db_design_intro:foreign_keys/payment_rental_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.payment
    ADD CONSTRAINT payment_rental_id_fk FOREIGN KEY (rental_id) REFERENCES rental.rental(rental_id) ON UPDATE CASCADE ON DELETE SET NULL;

COMMIT;
