-- Deploy db_design_intro:sequences/rental_rental_id_seq to pg
-- requires: appschema

BEGIN;

CREATE SEQUENCE rental.rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

COMMIT;
