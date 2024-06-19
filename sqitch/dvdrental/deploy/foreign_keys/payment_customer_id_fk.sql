-- Deploy db_design_intro:foreign_keys/payment_customer_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.payment
    ADD CONSTRAINT payment_customer_id_fk FOREIGN KEY (customer_id) REFERENCES rental.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
