-- Deploy db_design_intro:sequences/payment_payment_id_seq to pg
-- requires: appschema

BEGIN;

CREATE SEQUENCE rental.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

COMMIT;
