-- Revert db_design_intro:sequences/rental_rental_id_seq from pg

BEGIN;

DROP SEQUENCE rental.rental_rental_id_seq;

COMMIT;
