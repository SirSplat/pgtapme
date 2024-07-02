-- Deploy db_design_intro:sequences/store_store_id_seq to pg
-- requires: appschema

BEGIN;

CREATE SEQUENCE rental.store_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

COMMIT;
