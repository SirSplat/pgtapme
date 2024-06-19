-- Revert db_design_intro:sequences/address_address_id_seq from pg

BEGIN;

DROP SEQUENCE rental.address_address_id_seq;

COMMIT;
