-- Deploy db_design_intro:foreign_keys/rental_customer_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.rental
    ADD CONSTRAINT rental_customer_id_fk FOREIGN KEY (customer_id) REFERENCES rental.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
