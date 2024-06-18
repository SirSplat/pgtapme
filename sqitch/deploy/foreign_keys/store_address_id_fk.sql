-- Deploy db_design_intro:foreign_keys/store_address_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.store
    ADD CONSTRAINT store_address_id_fk FOREIGN KEY (address_id) REFERENCES rental.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
