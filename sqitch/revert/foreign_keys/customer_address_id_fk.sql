-- Revert db_design_intro:foreign_keys/customer_address_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.customer
    DROP CONSTRAINT customer_address_id_fk;

COMMIT;
